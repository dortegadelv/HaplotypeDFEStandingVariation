
import numpy, sys
import dadi
import Selection
import pickle

File=sys.argv[1]
ThetaFile=sys.argv[2]
ExitFile=sys.argv[3]
# NumberSFS=sys.argv[3]

# with open(ThetaFile) as f:
#  ThetaNumber = float(f.read())

#the demographic function we will be using for our analysis. This describes
#a two epoch model with one historical size change.
def two_epoch(params, ns, pts):
    nu, T = params
    xx = dadi.Numerics.default_grid(pts)
    phi = dadi.PhiManip.phi_1D(xx)
    phi = dadi.Integration.one_pop(phi, xx, T, nu)
    fs = dadi.Spectrum.from_phi(phi, ns, (xx,))
    return fs


#set demographic parameters and theta. this is usually inferred from
#synonymous sites
demog_params = [1, 0.01]
theta_ns = 1 * 2000
ns = numpy.array([4000])

#the demography + selection function. single size change and selection.
def two_epoch_sel(params, ns, pts):
    nu, T, gamma = params
    xx = dadi.Numerics.default_grid(pts)
    phi = dadi.PhiManip.phi_1D(xx, gamma=gamma)
    phi = dadi.Integration.one_pop(phi, xx, T, nu, gamma=gamma)
    fs = dadi.Spectrum.from_phi(phi, ns, (xx,))
    return fs

data = dadi.Spectrum.from_file(File)
# with open(ThetaFile, "r") as fp:   # Unpickling
#   NumberTheta = fp.read().rstrip()

theta_ns = float(ThetaFile)

with open("spectra_constantpopsize_objecttest.txt", "rb") as fp:   # Unpickling
   spectra = pickle.load(fp)

sel_params = [0.2, 1000.]
lower_bound = [1e-3, 1e-2]
upper_bound = [1, 50000.]
p0 = dadi.Misc.perturb_params(sel_params, lower_bound=lower_bound,
                              upper_bound=upper_bound)
popt = Selection.optimize_log(p0, data, spectra.integrate, Selection.gamma_dist, 
                              theta_ns, lower_bound=lower_bound, 
                              upper_bound=upper_bound, verbose=len(sel_params), 
                              maxiter=30)

print (popt)
f = open(ExitFile, "w")
f.write(str(popt))


f.close()

   
