#' Estimate latent class models with different numbers of classes
#'
#' Use this function to estimate latent class models with different
#' numbers of classes. Results for all models are given in a
#' single object.
#'
#' This is a convenience function, which uses the function
#' \code{\link[poLCA]{poLCA}} from the package with the same name,
#' to estimate latent class models with a user defined
#' maximum number of classes (k). The function will estimate
#' latent class models of 1:k classes. The output is a list,
#' each element of which is the \code{\link[poLCA]{poLCA}} output object
#' (also a list) for each of the latent class models estimated.


#' @param formula A formula expression of the form response ~ predictors.
#' @param data A data frame containing variables in formula.
#'     Manifest variables must contain only integer values, and must
#'     be coded with consecutive values from 1 to the maximum number of outcomes
#'     for each variable. All missing values should be entered as NA.
#' @param k The maximum number of classes required.
#' @param maxiter The maximum number of iterations through which the estimation algorithm will cycle.
#' @param graphs Logical, for whether poLCA should graphically display the parameter estimates
#'     at the completion of the estimation algorithm. The default is FALSE.
#' @param tol A tolerance value for judging when convergence has been reached.
#'     When the one-iteration change in the estimated log-likelihood is less than tol,
#'     the estimation algorithm stops updating and considers the maximum log-likelihood to have been found.
#' @param na.rm Logical, for how poLCA handles cases with missing values on the manifest variables.
#'     If TRUE, those cases are removed (listwise deleted) before estimating the model.
#'     If FALSE, cases with missing values are retained. Cases with missing covariates are always removed.
#'     The default is TRUE.
#' @param probs.start A list of matrices of class-conditional response probabilities to be used as the starting
#'     values for the estimation algorithm. Each matrix in the list corresponds to one manifest variable,
#'     with one row for each latent class, and one column for each outcome.
#'     The default is NULL, producing random starting values. Note that if nrep>1,
#'     then any user-specified probs.start values are only used in the first of the nrep attempts.
#' @param nrep Number of times to estimate the model, using different values of probs.start.
#'     The default is one. Setting nrep>1 automates the search for the global—rather than just a
#'     local—maximum of the log-likelihood function. poLCA returns the parameter estimates
#'     corresponding to the model with the greatest log-likelihood.
#' @param verbose Logical, indicating whether poLCA should output to the screen the results of the model.
#'     If FALSE, no output is produced. The default is TRUE.
#' @param calc.se Logical, indicating whether poLCA should calculate the standard errors of the estimated
#'     class-conditional response probabilities and mixing proportions.
#'     The default is TRUE; can only be set to FALSE if estimating a basic model with no concomitant
#'     variables specified in formula.
#'
#' @import poLCA
#' @importFrom foreach %do%
#'
#'
#' @return \code{\link{estimateModels}} returns a list of poLCA objects (that are also lists).
#'     Each element of the list is the poLCA object for each the latent class
#'     models estimated (i.e. the parameter estimates and other model information
#'     of the latent class models with one, two, etc classes). Please see package
#'     poLCA for full documentation.
#'
#' @examples
#' Estimate latent class models with 1,2,3 and 4 classes
#' Each model to iterate up to 5,000 times and the model estimated 10 times,
#' using different start values each time.
#' data(election)
#' f <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB) ~ 1
#' lc_models <- estimateModels(formula = f, data = election, k = 4, maxiter = 5000, nrep = 10)
#'
#' @seealso \code{\link[poLCA:poLCA]{poLCA}}

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


