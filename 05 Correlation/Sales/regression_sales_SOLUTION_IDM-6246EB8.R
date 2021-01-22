# === Clean Up Workspace
rm(list = ls())

# === Download, install and load packages if needed
install.package.needed<-function(package.needed = NA)
{
  if (is.na(package.needed)) stop("Package name missing")

  new.packages <- package.needed[!(package.needed %in% installed.packages()[,"Package"])]

  if(length(new.packages))
  {
    install.packages(new.packages)
  }
  
  # load the packages
  library(package.needed,character.only=TRUE)
}

# ==== MAIN PART
# set warning messages to English
Sys.setenv(LANG = "en")

# set work directory
setwd("Z:/D/VL_MPMD_Stats_With_R/002 Course Material/Part 3 R/005_User-defined_Functions")

# import Excel file
install.package.needed("readxl")
sales <- read_excel("004b Sales.xlsx")

# convert to dataframe
sales<-data.frame(sales)
head(sales)

# copy sales to x
x<-sales

# === Correlation
# here using cor.test to get also the significance
# interpret the significance in detail!
cor.test(x$sales,x$price)

# === fitting a linear regression model
lm.model<-lm(sales~price,data=x)

# print just the equation
lm.model

# detailed statistics of model
summary(lm.model)

# confidence intervals for parameter based on standard errors - correct if model meets assumptions!
confint(lm.model,level=0.95)

# add predictions to data frame
x$forecast<-fitted(lm.model)

#add residuals to the data frame
x$residuals<-resid(lm.model)

# add predictions to data frame
x$z.forecast<-scale(fitted(lm.model))

#add stanardized residuals to the data frame
x$z.residuals<-rstandard(lm.model)

# === using the model to forecast
# define a data frame with the given values, here a known value 49 to compare the result - see 1st row of original data
new.values<-data.frame(matrix(c(49),nrow=1,ncol=1))
colnames(new.values)<-c("price")

# provide the given values to predict()
predict.lm(lm.model,new.values)

# === checking the assumptions
hist(x$z.residuals)

qqnorm(x$residuals)
qqline(x$residuals)
ks.test(x$residuals,"pnorm")
shapiro.test(x$residuals)

# checking for Homo-/Heteroskedasticity
plot(x$z.forecast,x$residuals,xlab="Fitted",ylab="Residuals")

# probably here also Durbin Watson Test for Autocorrelation
