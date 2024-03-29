% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compareModels.R
\name{compareModels}
\alias{compareModels}
\title{Create model selection statistics table}
\usage{
compareModels(data)
}
\arguments{
\item{data}{The output of the \code{\link{estimateModels}} function}
}
\value{
A dataframe containing the model selection statistics for each
of the latent class models estimated using the \code{\link{estimateModels}} function.
Each model (i.e. a model with one, two, etc. classes) occupies one row,
and each column is a separate statistic.
}
\description{
Use this function to extract model selection statistics from
the output of the \code{\link{estimateModels}} function. The output
is a dataframe.
}
\details{
This is a convenience function, which uses the output of
the \code{\link{estimateModels}} function from this package, to create
a table showing the model selection statistics for each of
the models estimated using the \code{\link{estimateModels}} function.
In addition to the model selection statistics calculated through
\code{\link[poLCA]{poLCA}}, this function calculates the
consistent Akaike Information criterion (cAIC) and the
sample-adjusted Bayesian Information Criterion (aBIC) as well
as the Lo-Mendell-Rubin Likelihood Ratio Test.
}
\examples{
Display model selection statistics for latent class models with 1,2,3 and 4 classes
data(election)
f <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB) ~ 1
lc_models <- estimateModels(formula = f, data = election, k = 4, maxiter = 5000, nrep = 10)
lc_stats <- compareModels(lc_models)
}
