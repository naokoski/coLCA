#' Estimate latent class models with different number of classes


#' This is a convenience function, which uses the function poLCA()
#' from the poLCA package to estimate latent class models
#' with a user defined maximum number of classes (k).
#' The function will estimate latent class models of 1:k classes.
#' The output is a list, each element of which is the poLCA() output object
#' (also a list) for each of the latent class models estimated.


#' Estimate required LC models with different number of classes
#'
#' @param formula The latent class model (as documented in the poLCA package).
#' @param data A dataframe as documented in the poLCA package.
#' @param k The maximum number of classes required.
#' @param ... All other poLCA() arguments as documented in the poLCA package.
#'
#' @import poLCA
#' @importFrom foreach %do%
#'
#'
#' @return estimateModels returns a list of poLCA objects (that are also lists).
#'     Each element of the list is the poLCA object for each the latent class
#'     models estimated (i.e. the parameter estimates and other model information
#'     of the latent class models with one, two, etc classes). Please see package
#'     poLCA for full documentation.
#'
#' @examples
#' Estimate latent class models with 1,2,3 and 4 classes
#' Each model to iterate up to 5,000 times and
#' repeated 10 times.
#' data(election)
#' f <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB) ~ 1
#' lc_models <- estimateModels(formula = f, data = election, k = 4, maxiter = 5000, nrep = 10)

estimateModels <- function(formula, data, k,
                   maxiter, graphs,
                   tol, na.rm,
                   probs.start, nrep,
                   verbose, calc.se) {
  i <- NULL
  foreach::foreach(i = 1:k, .packages = "poLCA") %do% {
    poLCA::poLCA(formula, data, nclass = i, maxiter = 1000, graphs = FALSE,
                 tol = 1e-10, na.rm = TRUE, probs.start = NULL, nrep = 1,
                 verbose = TRUE, calc.se = TRUE)
  }
}


