####Module 11
###Wayne McClure
##LIS 4370

##Spot the bug

tukey_multiple <- function(x) 
{
  outliers <- array(TRUE,dim=dim(x))
  for (j in 1:ncol(x))
  {
    outliers[,j] <- outliers[,j] && tukey.outlier(x[,j])
  }
  outlier.vec <- vector(length=nrow(x))
  for (i in 1:nrow(x))
  { outlier.vec[i] <- all(outliers[i,]) } return(outlier.vec) }

#The above has a bug syntax spoacing anf formatting
##Adjusting gives a functional function

tukey_multiple <- function(x)
{
  outliers <- array(TRUE,dim=dim(x))
  for (j in 1:ncol(x))
  {
    outliers[,j] <- outliers[,j] && tukey.outlier(x[,j])
  }
  outlier.vec <- vector(length=nrow(x))
  for (i in 1:nrow(x))
  { outlier.vec[i] <- all(outliers[i,])
  
  }
  return(outlier.vec)
  
}

##load a dataset to test
df <- iris

tukey_multiple(df)

##Fails again because of the tukey.outlier there is a tukey_outlier function in a package called funModeling

library(funModeling)

tukey_multiple2 <- function(x)
{
  outliers <- array(TRUE,dim=dim(x))
  for (j in 1:ncol(x))
  {
    outliers[,j] <- outliers[,j] && tukey_outlier(x[,j])
  }
  outlier.vec <- vector(length=nrow(x))
  for (i in 1:nrow(x))
  { outlier.vec[i] <- all(outliers[i,])
  
  }
  return(outlier.vec)
  
}
tukey_multiple2(df)

##Error in quantile.default(input_cleaned, na.rm = T, names = F) : 
##(unordered) factors are not allowed
##Not an error of the function but of the dataset used. Let's remove the Species column and try again
df <- subset(df, select = -c(Species))

tukey_multiple2(df)
##And we have a successful function!