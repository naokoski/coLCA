library(tidyverse)
library(poLCA)
library(foreach)

#' Estimate LC models with different number of classes


#' this function takes the maximum number of classes one wants to run
#' then runs models from 1 class to the maximum amount of classes
#' outputs the result as a list
#' user needs to define the model, maximum iterations and number of repetitions


#' Estimate required LC models with different number of classes
#'
#' @param data The dataset used
#' @param k The maximum number of classes required
#' @param formula The LC model (as documented in poLCA)
#' @param maxiter The maximum number of iterations
#' @param nrep Number of times that model should be estimated using different starting values
#'
#' @return A list
#' @export
#'
#' @examples
#' Estimate LC models with 1,2,3 and 4 classes
#' Each model to iterate up to 5,000 times and
#' repeated 10 times.
#' models(data, 4, f, 5000, 10)

models <- function(data, k, formula, maxiter, nrep) {
  foreach(i = 1:k, .packages = "poLCA") %do%
    poLCA(formula, data, nclass = i,
          maxiter = maxiter, nrep = nrep)
}

