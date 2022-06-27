
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coLCA

<!-- badges: start -->
<!-- badges: end -->

The goal of coLCA is to create some additional functionality for the
poLCA package. It provides convenience functions to improve workflow and
some additional statistics (cAIC, aBIC and the LMR LRT).

## Installation

You can install the development version of coLCA from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("naokoski/coLCA")
```

## Usage

coLCA provides convenience functions for estimating all the required
latent class models from a single function call, which also calculates
additional information criteria (consistent AIC and sample-adjusted
BIC), not provided in poLCA. A second function extracts all the model
selectcion statistics and outputs them as a dataframe for easy
comparison; the function also compares each model of k classes to the
model of k+1 classes using the Lo-Mendell-Rubin Likelihood Ratio Test
that is not available in poLCA.

It is common, when performing Latent Class Analysis, that the researcher
will estimate a number of models each with an additional class, which
will then be compared using statistics and the researcher’s own
judgment, in order to choose the model which performs best and at the
same time fits well with current knowledge.

When using the poLCA package, each model needs to be run individually
and each of the results saved. Model selection statistics then need to
be extracted from each model output object and tabulated in order to be
compared and used in publications. This package provides convenience
functions to improve this workflow and outputs. One function allows the
researcher to provide the maximum number of classes they wish to
estimate and the function will return a list containing all the model
outputs between one and the maximum number of classes set by the
researcher. A second function takes this output, extracts all the
necessary statistics and outputs them as a dataframe.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(coLCA)

##' Estimate latent class models with 1,2,3 and 4 classes
##' Each model to iterate up to 5,000 times and repeated 10 times.
##' 
##' data(election)
##' 
##' Define the model (the example is of a latent class model with no covariates)
##' f <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB) ~ 1
##' 
##' The argument k is the only argument not included in the poLCA() function. All other arguments are the same.
##' lc_models <- estimateModels(formula = f, data = election, k = 4, maxiter = 5000, nrep = 10)
##' 
##' Create a dataframe containing the model selection statistics for each of the 
##' latent class models estimated
##' 
##' lc_stats <- compareModels(lc_models)
```
