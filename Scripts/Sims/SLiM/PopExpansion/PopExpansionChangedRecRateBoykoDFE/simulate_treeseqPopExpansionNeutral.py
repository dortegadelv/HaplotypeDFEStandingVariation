#! /usr/bin/env python3

import gzip
import numpy as np
import sys
import argparse
import os

def read_boundaries_as_dict():
    bounds = gzip.open('./annotations/hg19.recomb.boundaries.txt.gz')
    bounds = bounds.readlines()
    bounds = [x.decode('utf_8').strip('\n').split(' ') for x in bounds]
    bounds = [[x[0], {"start": int(x[1]), "stop": int(x[2])}] for x in bounds]
    bounds = dict(bounds)
    return bounds

def overlap(a, b):
    return max(0, min(a[1], b[1]) - max(a[0], b[0]) + 1)

def make_sim_seq_info(chrom="NULL", start="NULL", size=100000,
                      filename="sim_seq_info.txt"):
    if chrom == "NULL":
        start = 0
        stop = start + size - 1
        recRate = 1e-8 * 5
        annots = []
        recomb = ["recRate {} {}".format(stop, recRate)]
    else:
        bounds = read_boundaries_as_dict()
        stop = start + size - 1
        if (start < bounds[chrom]['start']) or (stop > bounds[chrom]['stop']):
            raise ValueError("outside the bounds of the recomb map")
        #read annotations
        annots_file = './annotations/hg19.{}.annot.txt.gz'.format(chrom)
        annots_chr = gzip.open(annots_file).readlines()
        annots_chr = [x.decode('utf_8').strip('\n').split(' ') for
                      x in annots_chr]
        annots_chr = [x for x in annots_chr if
                      overlap([start, stop], list(map(int, x[1:3]))) > 0]
        annots_chr = [[x[0], int(x[1]), int(x[2])] for x in annots_chr]
        #trim minimum
        annots_chr = [x if x[1] >= start else [x[0],start,x[2]] for
                      x in annots_chr]
        #trim maximum
        annots_chr = [x if x[2] <= stop else [x[0],x[1],stop] for
                      x in annots_chr]
        #read recomb file
        recomb_file = './annotations/hg19.recomb.map.txt.gz'
        recomb_chr = gzip.open(recomb_file).readlines()
        recomb_chr = [x.decode('utf_8').strip("\n").split(" ")
                      for x in recomb_chr]
        recomb_chr = [x for x in recomb_chr if x[0] == chrom]
        recomb_chr = [x for x in recomb_chr if
                      overlap([start,stop], list(map(int, x[1:3]))) > 0]
        recomb_chr = [[x[0], int(x[1]), int(x[2]), x[3]] for x in recomb_chr]
        #trim minimum
        recomb_chr = [x if x[1] >= start else [x[0],start,x[2],x[3]] for
                      x in recomb_chr]
        #trim maximum
        recomb_chr = [x if x[2] <= stop else [x[0],x[1],stop,x[3]] for
                      x in recomb_chr]
        #assemble chromosome
        annots = ['{} {} {}'.format(x[0],x[1]-start,x[2]-start) for
                  x in annots_chr]
        recomb = ['recRate {} {}'.format(x[2] - start, x[3]) for
                  x in recomb_chr]
    #now combine all annotations
    sequence_info = annots + recomb
    outfile = open(filename, 'w')
    if chrom == "NULL":
        outfile.write('Test chr1:{0}-{1}\n'.format(start,stop))
    else:
        outfile.write('Human {0}:{1}-{2}\n'.format(chrom,start,stop))
    outfile.write('\n'.join(sequence_info))
    outfile.close()

def init_block_fun(mu, scalingfactor, es, shape, smin, smax, simseqinfoname, cnc=False):
    init= '''
    // set up a simple neutral simulation
    initialize() {{
        initializeMutationRate({0}*(2.31/3.31)*{1});
        initializeTreeSeq();

        // m1 mutation type: nonsyn
        // muts added at 2.31/3.31 the mutation rate, syn muts added w/msprime
        initializeMutationType("m1", 0, "f", 0.0);

        // m2 mutation type: adaptive
        initializeMutationType("m2", 0.5, "s", "return runif(1,{4}, {5});");
        m2.convertToSubstitution == T;

        // m3 mutation type: cnc with DFE from Torgerson et al., 2009
        initializeMutationType("m3", 0, "f", 0.0);
        m3.convertToSubstitution == T;

        //genomic element: exon and uses a mixture of syn and nonsyn at a 1:2.31 ratio (Huber et al.)
        initializeGenomicElementType("g1", c(m1), c(1.0)); // no synonymous muts

        //genomic element: cnc
        initializeGenomicElementType("g2", c(m3), c(1.0));

        //read in exon and recomb info
        info_lines = readFile("{6}");

        //recombination
        rec_ends = NULL;
        rec_rates = NULL;
        for (line in info_lines[substr(info_lines, 0, 2) == "rec"])
        {{
            components = strsplit(line, " ");
            rec_ends = c(rec_ends, asInteger(components[1]));
            rec_rates = c(rec_rates, asFloat(components[2]));
        }}
        //multiply rec rates by scaling factor
        initializeRecombinationRate(0.5*(1-(1-2*rec_rates)^{1}), rec_ends);

        //exons
        for (line in info_lines[substr(info_lines, 0, 2) == "exo"])
        {{
            components = strsplit(line, " ");
            exon_starts = asInteger(components[1]);
            exon_ends = asInteger(components[2]);
            initializeGenomicElement(g1, exon_starts, exon_ends);
        }}

        //conserved non-coding
        //maybe incorporate this later
        for (line in info_lines[substr(info_lines, 0, 2) == "cnc"])
        {{
            components = strsplit(line, " ");
            cnc_starts = asInteger(components[1]);
            cnc_ends = asInteger(components[2]);
            initializeGenomicElement(g2, cnc_starts, cnc_ends);
        }}
    }}
    '''.format(mu, scalingfactor, es, shape, smin, smax, simseqinfoname)
    return init.replace('\n    ','\n')

def fitness_block_fun(Tcurr):
    fitness_block='''
    1:{0} fitness(m1) {{
        h = mut.mutationType.dominanceCoeff;
        if (homozygous) {{
            return ((1.0 + 0.5*mut.selectionCoeff)*(1.0 + 0.5*mut.selectionCoeff));
        }} else {{
            return (1.0 + mut.selectionCoeff * h);
        }}
    }}
    '''.format(10100)
    return fitness_block.replace('\n    ','\n')

def demog_block_fun_neu(nrep, Nanc, Tafnea, Nnea, Taf, Naf, Tb, Nb, mafb, Tadm,
                    mafnea, Teuas, Nas0, mafas, Tcurr, ras, Tneasamp):
    rand_seeds = 'c(' + ','.join([str(__import__('random').
                  randint(0,10000000000000)) for x in range(0,nrep)]) + ')'
    demog_block='''
    // burn-in for ancestral population
    1 early(){{
    setSeed({0}[simnum]); //define with -d simnum=$SGE_TASK_ID
    sim.addSubpop("p1", 1000); }}
    10000 {{
    p1.setSubpopulationSize(10000);
    }}
    '''.format(rand_seeds)
    return demog_block.replace('\n    ','\n')

def demog_block_fun_ai(nrep, Nanc, Tafnea, Nnea, Taf, Naf, Tb, Nb, mafb, Tadm,
                        mafnea, Teuas, Nas0, mafas, Tcurr, ras, Tneasamp):
    ai_times = ('c(' + ','.join([str(__import__('random').
    randint(tburn+1,tburn+tsplit1+tsplit2)) for x in range(0,nrep)]) +
    ')')

def output_block_fun(Tcurr, treefilename):
    output_block='''
    {0} late() {{
        sim.treeSeqOutput("{1}");
    }}
    '''.format(10020, treefilename)
    return output_block.replace('\n    ','\n')

def main(args):
    scalingfactor = args.scalingfactor
    #demographic parameters from Gravel et al. PNAS
    Nanc = 7300. #ancestral human size
    Nnea = 1000. #neanderthal population size
    Naf = 14474. #African population size
    Nb = 1861. #out of Africa bottleneck size
    Nas0 = 550. #Asian founder bottleneck size
    Nasc = 45370. #Asian current day size
    Tafnea = Nanc*10. #burn in for 10Na generations
    Taf = Tafnea + 10400. #neanderthal - afr split time
    Tb = Taf + 3560. #out of Africa bottleneck time
    Tadm = Tb + 440. #neanderthal admixture time
    Tneasamp = Tadm + 80. #Neanderthal lineage sampling time (age of sample)
    Teuas = Tneasamp + 600. #Asian founder bottleneck time
    Tcurr = 10000 #Current day time
    mafnea = 0.10 #initial Neanderthal admixture proportion
    mafb = 0.00015 #migration rate between Africa and Asn-Eur progenitor popn
    mafas = 0.0000078 #migration rate between Africa and Asn
    ras = 1 + 0.0048*scalingfactor #growth rate of modern Asn
    #now, rescale all parameters by the scaing factor
    Nanc = int(round(Nanc/scalingfactor))
    Nnea = int(round(Nnea/scalingfactor))
    Naf = int(round(Naf/scalingfactor))
    Nb = int(round(Nb/scalingfactor))
    Nas0 = int(round(Nas0/scalingfactor))
    Nasc = int(round(Nasc/scalingfactor))
    Tafnea = int(round(Tafnea/scalingfactor))
    Taf = int(round(Taf/scalingfactor))
    Tb = int(round(Tb/scalingfactor))
    Tadm = int(round(Tadm/scalingfactor))
    Tneasamp = int(round(Tneasamp/scalingfactor))
    Teuas = int(round(Teuas/scalingfactor))
    Tcurr = int(round(Tcurr/scalingfactor))
    #population parameters
    mu=args.mu*scalingfactor #mutation rate
    es=args.es*scalingfactor #fixed human DFE
    shape=args.shape
    smin=args.smin*scalingfactor
    smax=args.smax*scalingfactor
    #set output file names
    cwd = os.getcwd()
    simseqinfoname = '{0}/sim_seq_info_{1}.txt'.format(cwd, args.output)
    slimfilename = '{0}/sim_{1}.slim'.format(cwd, args.output)
    treefilename = '{0}/trees_{1}_" + simnum + ".trees'.format(cwd, args.output)
    #generate generic chromosome structure file with hg19
    make_sim_seq_info(chrom=args.chrom, start=args.start, size=args.size,
                      filename=simseqinfoname)
    #make pieces of slim script
    init_block = init_block_fun(args.mu, scalingfactor, args.es, args.shape,
                                args.smin, args.smax, simseqinfoname)
    fitness_block = fitness_block_fun(Tcurr)
    demog_block = demog_block_fun_neu(args.nrep, Nanc, Tafnea, Nnea, Taf, Naf,
                                      Tb, Nb, mafb, Tadm, mafnea, Teuas, Nas0,
                                      mafas, Tcurr, ras, Tneasamp)
    output_block = output_block_fun(Tcurr, treefilename)
    #output slim file
    outputs = (init_block + '\n' + fitness_block + '\n' + demog_block + '\n' +
               output_block)
    outfile = open(slimfilename, 'w')
    outfile.write(outputs)
    outfile.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A script for preparing SLiM simulation scripts. Random variables and seeds are hardcoded into the SLiM script. Array job numbers are passed directly to SLiM: './slim -d simnum=$SGE_TASK_ID'.")
    parser.add_argument('-o', '--output', action="store", dest="output",
                        help="output suffix, default: 'test'", default="test",
                        type=str)
    parser.add_argument('-c', '--chr', action="store", dest="chrom",
                        help="chromosome format, default: 'chr1'",
                        default="chr1", type=str)
    parser.add_argument('-s', '--start', action="store", dest="start",
                        help="starting coordinate, default: 10000000",
                        default=10000000, type=int)
    parser.add_argument('-z', '--size', action="store", dest="size",
                        help="size of chunk to simulate, default: 10000000",
                        default=20000000, type=int)
    parser.add_argument('-x', '--scalingfactor', action="store",
                        dest="scalingfactor", help="simulation scaling factor, default: 10",
                        default=5, type=float)
    parser.add_argument('-m', '--mu', action="store", dest="mu",
                        help="mutation rate, default: 1.8e-8",
                        default=1.2e-8, type=float)
    parser.add_argument('-e', '--es', action="store", dest="es",
                        help="expected sel coeff of gamma DFE, E[s], default:-0.01026",
                        default=-0.01026, type=float)
    parser.add_argument('-a', '--alpha', action="store", dest="shape",
                        help="shape parameter of the gamma DFE, default: 0.186",
                        default=0.186, type=float)
    parser.add_argument('-l', '--smin', action="store", dest="smin",
                        help="min advantageous sel coeff, default: 0.00125",
                        default=0.00125, type=float)
    parser.add_argument('-u', '--smax', action="store", dest="smax",
                        help="max advantageous sel coeff, default: 0.0125",
                        default=0.0125, type=float)
    parser.add_argument('-n', '--nrep', action="store", dest="nrep",
                        help="number of simulation replicates, default: 1000",
                        default=1000, type=int)
    parser.add_argument('-t', '--simtype', action="store", dest="simtype",
                        help="simulation types: 'neutral', 'ai', 'ancient', 'hardsweep', or 'softsweep'. default: 'neutral'",
                        default="neutral", type=str)
    args = parser.parse_args()

    main(args)
