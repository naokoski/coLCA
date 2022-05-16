library(tidyverse)
library(poLCA)
library(foreach)

#' this function takes the maximum number of classes one wants to run
#' then runs models from 1 class to the maximum amount of classes
#' outputs the result as a list
#' user needs to define the model, maximum iterations and number of repetitions

#### Function to run all class models in parallel if needed (has not been possible)

models <- function(data, k, formula, maxiter, nrep) {
  foreach(i = 1:k, .packages = "poLCA") %do%
    poLCA(formula, data, nclass = i,
          maxiter = maxiter, nrep = nrep)
}

