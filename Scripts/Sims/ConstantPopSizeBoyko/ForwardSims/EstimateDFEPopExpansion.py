
import numpy, sys
import dadi
import Selection
import pickle

File=sys.argv[1]
ThetaFile=sys.argv[2]
NumberSFS=sys.argv[3]

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
demog_params = [10, 0.01]
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


Number= int(NumberSFS) * 0.01283162
Exponent = -3.69897 + Number
SelValue = 10**Exponent
ExitFile = "example_spectra"+ NumberSFS +".txt"

print (SelValue)
#integrate over a range of gammas without defining breaks
pts_l = [6000, 8000, 10000]
spectra = Selection.spectra(demog_params, ns, two_epoch_sel, pts_l=pts_l, 
                            int_bounds=(1e-4, 5000), Npts=600, echo=True)
with open("spectra_object", "wb") as fp:   #Pickling
   pickle.dump(spectra, fp)


#load sample data
# data = dadi.Spectrum.from_file(File)


#fit a DFE to the data
#initial guess and bounds
sel_params = [0.2, 1000.]
lower_bound = [1e-3, 1e-2]
upper_bound = [1, 50000.]
# p0 = dadi.Misc.perturb_params(sel_params, lower_bound=lower_bound,
#                              upper_bound=upper_bound)
# popt = Selection.optimize_log(p0, data, spectra.integrate, Selection.gamma_dist, 
#                               theta_ns, lower_bound=lower_bound, 
#                               upper_bound=upper_bound, verbose=len(sel_params), 
#                               maxiter=30)


# popt

