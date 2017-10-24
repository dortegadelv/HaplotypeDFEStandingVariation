S <- c(0.000001,-50,50,-100,100)

for (i in 1:5){
    print(S[i])
    integrand <- function(x) {((exp(S[i]*x)-1)*(exp(-S[i]*x)-exp(-S[i])))/(x*(1-x))}
    Value <- integrate(integrand, lower = 0, upper = 1)
    Stuff <- 40000/(S[i]*(1-exp(-S[i]))) * Value$value
    print(Value)
    integrand2 <- function(x) {((1-exp(-S[i]*(1-x)))*(exp(-S[i]*0.01)-exp(-S[i]*x)))/(x*(1-x))}
    Value2 <- integrate(integrand2, lower = 0.01, upper = 1)
    print(Value2)
    Stuff2 <- 40000/(S[i]*(exp(-S[i]*.01)-exp(-S[i]))) * Value2$value
    Whole <- Stuff - Stuff2
    print(Whole)
}

integrand <- function(x) {1/((x+1)*sqrt(x))}
integrate(integrand, lower = 0, upper = Inf)
