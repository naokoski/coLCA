#' Create model selection statistics table
#'
#' Use this function to extract model selection statistics from
#' the output of the \code{\link{estimateModels}} function. The output
#' is a dataframe.
#'
#' This is a convenience function, which uses the output of
#' the \code{\link{estimateModels}} function from this package, to create
#' a table showing the model selection statistics for each of
#' the models estimated using the \code{\link{estimateModels}} function.
#' In addition to the model selection statistics calculated through
#' \code{\link[poLCA]{poLCA}}, this function calculates the
#' consistent Akaike Information criterion (cAIC) and the
#' sample-adjusted Bayesian Information Criterion (aBIC) as well
#' as the Lo-Mendell-Rubin Likelihood Ratio Test.

#' @param data The output of the \code{\link{estimateModels}} function
#'
#' @import poLCA
#' @import tidyLPA
#' @import dplyr
#' @importFrom magrittr %>%
#'
#' @return A dataframe containing the model selection statistics for each
#'     of the latent class models estimated using the \code{\link{estimateModels}} function.
#'     Each model (i.e. a model with one, two, etc. classes) occupies one row,
#'     and each column is a separate statistic.
#'
#' @examples
#' Display model selection statistics for latent class models with 1,2,3 and 4 classes
#' data(election)
#' f <- cbind(MORALG,CARESG,KNOWG,LEADG,DISHONG,INTELG,MORALB,CARESB,KNOWB,LEADB,DISHONB,INTELB) ~ 1
#' lc_models <- estimateModels(formula = f, data = election, k = 4, maxiter = 5000, nrep = 10)
#' lc_stats <- compareModels(lc_models)







compareModels <- function(data) {
  entropy <- function (p) sum(-p*log(p)) #to assess the quality of classification
  indicies_table <- data.frame(NumberOfClasses = 0, AIC = 0, BIC = 0,
                               Log_lik = 0, Gsq = 0, Chisq = 0, df = 0,
                               Entropy = 0, SmallerClassSize = 0,
                               aBIC = 0, cAIC = 0, BICcalc = 0)   #empty data.frame to pre-allocate memory.
  for(i in 1:length(data)){
    indicies_table [i,1] <- paste(i, ifelse(i == 1, "class", "classes"))
    indicies_table [i,2] <- data[[i]]$aic
    indicies_table [i,3] <- data[[i]]$bic
    indicies_table [i,4] <- data[[i]]$llik
    indicies_table [i,5] <- data[[i]]$Gsq
    indicies_table [i,6] <- data[[i]]$Chisq
    indicies_table [i,7] <- data[[i]]$resid.df
    error_prior <- entropy(data[[i]]$P)
    error_post <- mean(apply(data[[i]]$posterior,1, entropy),na.rm = TRUE)
    indicies_table [i,8] <- round(((error_prior-error_post) / error_prior),3)
    indicies_table [i,9] <- min(data[[i]]$P)*100
    indicies_table [i,10] <- (-2*data[[i]]$llik) + data[[i]]$npar*(log((data[[i]]$N+2)/24))
    indicies_table [i,11] <- (-2*data[[i]]$llik) + data[[i]]$npar*(log(data[[i]]$N) + 1)
    indicies_table [i,12] <- (-2*data[[i]]$llik) + data[[i]]$npar*(log(data[[i]]$N))
  }

  lrt_table <- data.frame(Comparison_Classes=0, Lik_Ratio=0, LMR_Lik_Ratio=0,
                          LMRdf=0, pvalue=0)
  for(i in 1:(length(data)-1)){
      lrt <-
      tidyLPA::calc_lrt(n = data[[i]]$Nobs,#sample size
                        null_ll =  data[[i]]$llik, #LL of the null model
                        null_param = data[[i]]$npar, #no. of parameters of null model
                        null_classes = i, #no. of classes of null model
                        alt_ll = data[[i+1]]$llik, #LL of alternative model
                        alt_param = data[[i+1]]$npar, #no. of parameters in alternative model
                        alt_classes = i+1 #no. of classes in alternative model
      )
    lrt_table[i,1] <- paste(i+1, "to", i)
    lrt_table[i,2] <- lrt[1]
    lrt_table[i,3] <- lrt[2]
    lrt_table[i,4] <- lrt[3]
    lrt_table[i,5] <- lrt[4]
  }


  #### Add row so can cbind
  lrt_table <- rbind(c(0,0,0,0,0), lrt_table)

  #### Combine tables and return combined table
  comparison_table <- cbind(indicies_table, lrt_table) %>%
    dplyr::select(c("Number of classes" = "NumberOfClasses",
                    "AIC", "cAIC", "BIC", "aBIC", "Entropy",
                    "Smallest class size (%)" = "SmallerClassSize",
                    "Comparing models with number of classes:" = "Comparison_Classes",
                    "Lo-Mendell-Rubin Likelihood Ratio" = "LMR_Lik_Ratio",
                    "Lo-Mendell-Rubin degrees of freedom" = "LMRdf",
                    "Lo-Mendell-Rubin p-value" = "pvalue"))

  return(comparison_table)
}
