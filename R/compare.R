#'

compare_clases <- function(data) {
  entropy<-function (p) sum(-p*log(p)) #to assess the quality of classification
  indicies_table <- data.frame(NumberOfClasses=0, AIC = 0, BIC=0,
                          Log_lik=0, Gsq = 0, Chisq = 0, df = 0,
                          Entropy=0, SmallerClassSize=0,
                          aBIC=0, cAIC=0, BICcalc=0)   #empty data.frame to pre-allocate memory.
  for(i in 1:length(data)){
    indicies_table [i,1] <- paste(i, "classes")
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
      calc_lrt(n = data[[i]]$Nobs,#sample size
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

  #### Combine tables and save
  comparison_table <- cbind(indicies_table, lrt_table) %>%
    select(c("NumberOfClasses", "AIC", "cAIC", "BIC", "aBIC", "Entropy", "SmallerClassSize",
             "Comparison_Classes", "LMR_Lik_Ratio", "LMRdf", "pvalue"))

  return(comparison_table)
}
