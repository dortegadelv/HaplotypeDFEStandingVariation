Alpha = 0.184
Beta = 319.8626 * 4594/2000 * 5

TwoNs = 4594 * 5 * 1e-5
Prob <- pgamma(TwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 4594 * 5 * 1e-5
UpperTwoNs <- 4594 * 5 * 1e-4
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 4594 * 5 * 1e-4
UpperTwoNs <- 4594 * 5 * 1e-3
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

UpperTwoNs <- 4594 * 5 * 1e-3
Prob <- 1 - pgamma(UpperTwoNs,Alpha,scale=Beta)
Prob

### Alternative small size

Alpha = 0.184
Beta = 319.8626 * 4594/2000

TwoNs = 4594 * 1e-5
Prob <- pgamma(TwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 4594 * 1e-5
UpperTwoNs <- 4594 * 1e-4
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 4594 * 1e-4
UpperTwoNs <- 4594 * 1e-3
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

UpperTwoNs <- 4594 * 1e-3
Prob <- 1 - pgamma(UpperTwoNs,Alpha,scale=Beta)
Prob



### End of alternative

Alpha = 0.169
Beta = 1327.4 * 4594/(2*11261) * 5

TwoNs = 4594 * 5 * 1e-5
Prob <- pgamma(TwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 4594 * 5 * 1e-5
UpperTwoNs <- 4594 * 5 * 1e-4
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 4594 * 5 * 1e-4
UpperTwoNs <- 4594 * 5 * 1e-3
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

UpperTwoNs <- 4594 * 5 * 1e-3
Prob <- 1 - pgamma(UpperTwoNs,Alpha,scale=Beta)
Prob

#### Test other stuff


Alpha = 0.184
Beta = 319.8626 * 4594/2000

TwoNs = 0.5
TwoNs
Prob <- pgamma(TwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 0.5
UpperTwoNs <- 5
LowerTwoNs
UpperTwoNs
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

LowerTwoNs <- 5
UpperTwoNs <- 25
LowerTwoNs
UpperTwoNs
Prob <- pgamma(UpperTwoNs,Alpha,scale=Beta) - pgamma(LowerTwoNs,Alpha,scale=Beta)
Prob

UpperTwoNs <- 25
UpperTwoNs
Prob <- 1 - pgamma(UpperTwoNs,Alpha,scale=Beta)
Prob

### Two ways of getting it right
Alpha = 0.184
Beta = 319.8626 * 4594/2000 * 5

TwoNs = 22970 * 1e-5
TwoNs
Prob <- pgamma(TwoNs,Alpha,scale=Beta)
Prob


### Two ways of getting it right
Alpha = 0.184
Beta = 319.8626 * 4594/2000

TwoNs = 4594 * 1e-5
TwoNs
Prob <- pgamma(TwoNs,Alpha,scale=Beta)
Prob



