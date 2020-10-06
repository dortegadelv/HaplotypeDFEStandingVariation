#! /usr/bin/env python3

import pyslim
import msprime
import random
import itertools
import os
from operator import itemgetter
import argparse

def simplify_tree(filename, sample_sizes, archaic_sample_time):
    '''
    this method subsamples a tree sequence to a given set of
    sample sizes. archaic sample is set to be 1 individual in SLiM
    '''
    #load tree sequence
    ts = pyslim.load(filename)
    indivs = [x for x in ts.individuals()]
    #get nodes (chromosomes) alive today
    nodes_today_p1 = [x.id for x in ts.nodes() if ((x.time == 0.0) and
                      (x.population == 1))]
    nodes_today_p4 = [x.id for x in ts.nodes() if ((x.time == 0.0) and
                      (x.population == 4))]
    #get a list of the individuals alive today
    indivs_today_p1 = [x.id for x in indivs if x.nodes[0] in
                       nodes_today_p1]
    indivs_today_p4 = [x.id for x in indivs if x.nodes[0] in
                       nodes_today_p4]
    #subsample individuals to sample sizes
    indivs_sample_p1 = random.sample(indivs_today_p1, sample_sizes[0])
    indivs_sample_p4 = random.sample(indivs_today_p4, sample_sizes[1])
    #get their nodes
    nodes_sample_p1 = [x.nodes for x in indivs if x.id in
                       indivs_sample_p1]
    nodes_sample_p4 = [x.nodes for x in indivs if x.id in
                       indivs_sample_p4]
    nodes_sample_p1 = list(itertools.chain.from_iterable(
                           nodes_sample_p1))
    nodes_sample_p4 = list(itertools.chain.from_iterable(
                           nodes_sample_p4))
    #get archaic samples
    archaic = [x.id for x in ts.nodes() if x.time ==
               archaic_sample_time]
    indivs_archaic = [x.id for x in indivs if x.nodes[0] in archaic]
    nodes_sample_archaic = [x.nodes for x in indivs if x.id in
                            indivs_archaic]
    nodes_sample_archaic = list(itertools.chain.from_iterable(
                                nodes_sample_archaic))
    #subsample while retaining admixture recorded nodes
    samp = nodes_sample_archaic + nodes_sample_p1 + nodes_sample_p4
    ts_sample = ts.simplify(samples=samp, filter_populations=False)
    return ts_sample

def ns_vcf(ts, vcfoutpath):
    with open(vcfoutpath, "w") as vcf_file:
        ts.write_vcf(vcf_file)

def remove_mutations(ts, start, end, proportion):
    '''
    This function will return a new tree sequence the same as the input,
    but after removing each non-SLiM mutation within regions specified in lists
    start and end with probability `proportion`, independently. So then, if we
    want to add neutral mutations with rate 1.0e-8 within the regions and 0.7e-8
    outside the regions, we could do
      ts = pyslim.load("my.trees")
      first_mut_ts = msprime.mutate(ts, rate=1e-8)
      mut_ts = remove_mutations(first_mut_ts, start, end, 0.3)
    :param float proportion: The proportion of mutations to remove.
    '''
    tables = ts.dump_tables()
    tables.sites.clear()
    tables.mutations.clear()
    for tree in ts.trees():
        for site in tree.sites():
            assert len(site.mutations) == 1
            mut = site.mutations[0]
            keep_mutation = True
            for i in range(len(start)):
                left = start[i]
                right = end[i]
                assert(left < right)
                if i > 0:
                    assert(end[i - 1] <= left)
                if left <= site.position < right:
                    keep_mutation = (random.uniform(0, 1) > proportion)
            if keep_mutation:
                site_id = tables.sites.add_row(
                    position=site.position,
                    ancestral_state=site.ancestral_state)
                tables.mutations.add_row(
                    site=site_id, node=mut.node, derived_state=mut.derived_state)
    return tables.tree_sequence()

def noncoding_vcf(ts, vcfoutpath, mu, start, end, proportion=1.):
    ts = pyslim.SlimTreeSequence(msprime.mutate(ts, rate=float(mu),
         keep=False))
    proportion = 1.
    ts = remove_mutations(ts, start, end, proportion)
    with open(vcfoutpath, "w") as vcf_file:
        ts.write_vcf(vcf_file)

def syn_vcf(ts, vcfoutpath, mu, start, end):
    mu = 1/3.31*mu
    ts = pyslim.SlimTreeSequence(msprime.mutate(ts, rate=float(mu),
         keep=False))
    proportion = 1.0
    first = ts.first().interval[0]
    last = ts.last().interval[1]
    new_start = [first] + [x for x in end[0:(len(end))]]
    new_end = [x for x in start[0:(len(start))]] + [last]
    ts = remove_mutations(ts, new_start, new_end, proportion)
    with open(vcfoutpath, "w") as vcf_file:
        ts.write_vcf(vcf_file)

def main(args):
    #set file names
    treefilename = 'trees_{0}_{1}.trees'.format(args.inputname, args.simnum)
    exonfilepath = 'sim_seq_info_{0}.txt'.format(args.inputname)
    #compute admixture time
    scalingfactor = args.scalingfactor
    archaic_sample_time = round(1520./scalingfactor)
    #number of individuals from [afr, asn]
    sampsize=[2000,0] #Neanderthal is 1
    #read in exon definitions
    lines = open(exonfilepath, 'r').readlines()
    lines = [x for x in lines if x.startswith('exon')]
    lines = [x.strip('\n').split(' ') for x in lines]
    annot, start, end = zip(*lines)
    start = [int(x) for x in start]
    end = [int(x) for x in end]
    #downsample from trees
    ts_sample = simplify_tree(treefilename, sampsize, archaic_sample_time)
    print ("Here?")
    ns_vcf(ts_sample, '{0}_{1}_ns.vcf'.format(args.inputname, args.simnum))
    cmd = '''
    vcftools --vcf {0}_{1}_ns.vcf --freq --out Salele{1}.vcf
    awk '{{print $6}}' Salele{1}.vcf.frq | cut -d ':' -f 2 | grep -w "0.01" | wc -l | awk '{{print $1}}' > {0}_{1}_allelenumber.txt
    '''.format(args.inputname, args.simnum).replace('\n    ','\n')
    os.system(cmd)
    filepath = '{0}_{1}_allelenumber.txt'.format(args.inputname, args.simnum)
    print ("Here? 1.5")
    with open(filepath) as fp:
       cnt = 1
       for line in fp:
          AlleleNumber = line.rstrip()
          print(line)
          break
    fp.close()
    print ("Check " + AlleleNumber)
    print ("Here? 1.6")
    print ("Here? Part 2")
    noncoding_vcf(ts_sample, '{0}_{1}_noncoding.vcf'.format(args.inputname, args.simnum),
                  args.mu, start, end)
    print ("Here? Part 3")
    syn_vcf(ts_sample, '{0}_{1}_syn.vcf'.format(args.inputname, args.simnum), args.mu,
            start, end)
    print ("Here? Part 4")
    cmd = '''
    bcftools sort {0}_{1}_ns.vcf -o {0}_{1}_ns.vcf
    cat {0}_{1}_ns.vcf | grep "##" > {0}_{1}_unsorted.vcf;
    echo '##INFO=<ID=TT,Number=A,Type=String,Description="Annotation">' >> {0}_{1}_unsorted.vcf;
    cat {0}_{1}_ns.vcf | grep "#CHROM" >> {0}_{1}_unsorted.vcf;
    cat {0}_{1}_ns.vcf | grep -v "#" | awk '$8="TT=NS"' | tr ' ' '\t' >> {0}_{1}_unsorted.vcf;
    cat {0}_{1}_syn.vcf | grep -v "#" | awk '$8="TT=SYN"' | tr ' ' '\t' >> {0}_{1}_unsorted.vcf;
    cat {0}_{1}_noncoding.vcf | grep -v "#" | awk '$8="TT=NC"' | tr ' ' '\t' >> {0}_{1}_unsorted.vcf;
    # bcftools sort {0}_{1}_unsorted.vcf -o {0}_{1}_unsorted.vcf
    # rm {0}_{1}_ns.vcf; rm {0}_{1}_syn.vcf; rm {0}_{1}_noncoding.vcf;
    bcftools sort {0}_{1}_unsorted.vcf -o {0}_{1}_combined.vcf
    # rm {0}_{1}_unsorted.vcf
    '''.format(args.inputname, args.simnum).replace('\n    ','\n')
    print ("Here? Part 5")
    os.system(cmd)
    print ("Here? Part 6")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A script for converting tree sequence out from SLiM into VCF format given some exon map. BCFtools must be installed for this to work properly.")
    parser.add_argument('-i', '--input', action="store", dest="inputname",
                        help="suffix from  previous step, default: 'test'",
                        default="test", type=str)
    parser.add_argument('-n', '--simnum', action="store", dest="simnum",
                        help="simulation number, default: 1",
                        default=1, type=int)
    parser.add_argument('-x', '--scalingfactor', action="store",
                        dest="scalingfactor",
                        help="simulation scaling factor, default: 10",
                        default=5, type=int)
    parser.add_argument('-m', '--mu', action="store", dest="mu",
                        help="mutation rate, default: 1.2e-8", default=1.2e-8 * 5,
                        type=float)
    args = parser.parse_args()

    main(args)
