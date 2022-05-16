library(tidyverse)
library(poLCA)
library(foreach)

#' this function takes the maximum number of classes one wants to run
#' then runs models from 1 class to the maximum amount of classes
#' outputs the result as a list
#' user needs to define the model, maximum iterations and number of repetitions

#### Define LCA regression model. Complete case analysis (270 cases excl.)

f <- cbind(II, III, IV, VI,VII,
           IX, X, XI, XII, XIII, XIV) ~ Age2018_categories + Gender + Ethnicity_collapsed +
  F2 + F30 + F31 + IMD15_Quintile



#### Function to run all class models in parallel if needed (has not been possible)

models <- function(data, k, formula, maxiter, nrep) {
  foreach(i = 1:k, .packages = "poLCA") %do%
    poLCA(formula, data, nclass = i,
          maxiter = maxiter, nrep = nrep)
}

