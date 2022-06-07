#' Estimate LC models with different number of classes


#' this function takes the maximum number of classes one wants to run
#' then runs models from 1 class to the maximum amount of classes
#' outputs the result as a list
#' user needs to define the model, maximum iterations and number of repetitions


#' Estimate required LC models with different number of classes
#'
#' @param formula The latent class model (as documented in poLCA)
#' @param data The dataset used
#' @param k The maximum number of classes required
#' @param maxiter The maximum number of iterations
#' @param graphs Shall the output include graphs?
#' @param tol Tolerance
#' @param na.rm Remove missing values?
#' @param probs.start If starting values are to be entered manually
#' @param nrep Number of times that model should be estimated using different starting values
#' @param verbose NOT SURE CHECK
#' @param calc.se Calculate standard errors?
#'
#' @import poLCA
#' @importFrom foreach %do%
#'
#'
#' @return A list
#'
#' @examples
#' Estimate LC models with 1,2,3 and 4 classes
#' Each model to iterate up to 5,000 times and
#' repeated 10 times.
#' models(data, 4, f, 5000, 10)

models <- function(formula, data, k,
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

