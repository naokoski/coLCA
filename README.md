
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coLCA

<!-- badges: start -->
<!-- badges: end -->

The goal of coLCA is to create some additional functionality for the
poLCA package. It provides convenience functions to for estimating all
the required models from a single function call, which also calculates
additional information criteria (consistent AIC and sample-adjusted
BIC), not provided in poLCA. A second function extracts all the model
selectcion statistics and outputs them as a dataframe for easier
comparison, including the Lo-Mendell-Rubin Likelihood Ratio Test that is
not available in poLCA.

## Installation

You can install the development version of coLCA from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("naokoski/coLCA")
```

## Usage

There are a number of information criteria addtitional to the most
commonly known AIC and BIC that should be used under different
circumstances. Two additional criteria calculated with this package are
the consistent Akaike Information Criterion (cAIC) and the
sample-adjusted Bayesian Information Criterion (aBIC). An additional
measure of model fit - the Lo-Mendel-Rubio Likelihood Ratio Test is also
calculated as well as a more commonly used measure of entropy. Finally
two convenience functions: one to estimate all LC models needed using
only one call and a second one to output all the statistical criteria
for model selection in one table.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(coLCA)

## Estimate latent class models with 1,2,3 and 4 classes
## Each model to iterate up to 5,000 times and repeated 10 times.
## data(election)
## Define the model (the example is of a latent class model with no covariates)
## f <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB) ~ 1
## The argument k is the only argument not included in the poLCA() function. All other arguments are the same.
## lc_models <- estimateModels(formula = f, data = election, k = 4, maxiter = 5000, nrep = 10)
```
