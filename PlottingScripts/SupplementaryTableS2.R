setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")


########## Calculations for comparisons with Bernard Kim's 2017 paper using N = 2297, which is a factor of five times smaller than the actual population size.

### P (allele is 2Ns = x | allele is at 1%)

Alpha = 0.1
Beta = 250

P_Allele_Is_2Ns_given_OnePercent <- c()
NumberOfAllelesAt2Ns <- c()


# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Beta))

Prob <- pgamma(0.04594,Alpha,scale=Beta) - pgamma(0,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

Prob <- pgamma(0.4594,Alpha,scale=Beta) - pgamma(0.04594,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

Prob <- pgamma(4.594,Alpha,scale=Beta) - pgamma(0.4594,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

Prob <- pgamma(45.94,Alpha,scale=Beta) - pgamma(4.594,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

Prob <- 1 - pgamma(45.94,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

### P (allele is at 1%)

Alpha = 0.184
Beta = 319.8626 * 4594/2000

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))

    # print (i)
    Prob <- pgamma(0.04594,Alpha,scale=Beta) - pgamma(0,Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

# print (i)
Prob <- pgamma(0.4594,Alpha,scale=Beta) - pgamma(0.04594,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

# print (i)
Prob <- pgamma(4.594,Alpha,scale=Beta) - pgamma(0.4594,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

# print (i)
Prob <- pgamma(45.94,Alpha,scale=Beta) - pgamma(4.594,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

# print (i)
Prob <- 1 - pgamma(45.94,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

SelectionCoefficientList <- read.table("../Results/ExitSValues/ExitOnePercentSValuesUK10K.txt")

TwoNsValues <- SelectionCoefficientList$V2*2*11485/5

Check <- hist(TwoNsValues,breaks=c(0,0.04594,0.4594,4.594,45.94,4594000000))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2Ns= Counts_At_OnePercent_Given2Ns/ NumberOfAllelesAt2Ns


###### The whole stuff

Probs <- P_Allele_Is_2Ns_given_OnePercent

Probs <- Probs[1:5] / Probabilities_At_One_Percent_Given_2Ns[1:5]

Probs <- Probs[1:5] / sum (Probs[1:5] )

Probs


################# Finish here



########## Calculations for comparisons with Bernard Kim's 2017 paper using N = 11,485, which is a factor of five times smaller than the actual population size.

### P (allele is 2Ns = x | allele is at 1%)

Alpha = 0.1
Beta = 250

P_Allele_Is_2Ns_given_OnePercent <- c()
NumberOfAllelesAt2Ns <- c()


# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Beta))

Prob <- pgamma(0.2297,Alpha,scale=Beta) - pgamma(0,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

Prob <- pgamma(2.297,Alpha,scale=Beta) - pgamma(0.2297,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

Prob <- pgamma(22.97,Alpha,scale=Beta) - pgamma(2.297,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

Prob <- 1 - pgamma(22.97,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
# NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*186509)

### P (allele is at 1%)

Alpha = 0.184
Beta = 319.8626 * 4594/2000

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))

# print (i)
Prob <- pgamma(0.2297,Alpha,scale=Beta) - pgamma(0,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

# print (i)
Prob <- pgamma(2.297,Alpha,scale=Beta) - pgamma(0.2297,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

# print (i)
Prob <- pgamma(22.97,Alpha,scale=Beta) - pgamma(2.297,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

# print (i)
Prob <- 1 - pgamma(22.97,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((22971 + (9109/4594)*1221 + (1171/4594)*352 + (2674/4594)*229 + (220758/4594)*61 )*2500*1000)) # Original Test
#    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))

SelectionCoefficientList <- read.table("../Results/ExitSValues/ExitOnePercentSValuesUK10K.txt")

TwoNsValues <- SelectionCoefficientList$V2*2*11485/5

Check <- hist(TwoNsValues,breaks=c(0,0.2297,2.297,22.97,2297000000))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2Ns= Counts_At_OnePercent_Given2Ns/ NumberOfAllelesAt2Ns


###### The whole stuff

Probs <- P_Allele_Is_2Ns_given_OnePercent

Probs <- Probs[1:4] / Probabilities_At_One_Percent_Given_2Ns[1:4]

Probs <- Probs[1:4] / sum (Probs[1:4] )

Probs

