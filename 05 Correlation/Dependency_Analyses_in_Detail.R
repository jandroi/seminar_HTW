# Use working directory to write scripts which are independent from folder structure
setwd("D:/Documents/PAIG/seminar_HTW/05 Correlation")

# === Set Warnings to English
Sys.setenv(LANG=en)

# === Clean Up Workspace
rm(list = ls())

# read file
library(haven)
#load("002_employee_survey_details.RData")
employee.survey <- read_sav("005b_employee_survey_details.sav")

# preview
head(employee.survey)

# convert to data frame
class(employee.survey)
employee.survey<-data.frame(employee.survey)

# show data
head(employee.survey)

# determine sample size
dim(employee.survey)

attach(employee.survey)

# === assess dependencies using diagrams
boxplot(salary ~ gender,data = employee.survey, col = "lightgray",xlab="gender",ylab="salary",names=c("female","male"))
boxplot(age ~ gender,data = employee.survey, col ="lightgray",xlab="gender",ylab="age",names=c("female","male"))

# === binning age
# define catgeories

age.thresholds<-c(0,27,40,65)
age.labels<-c('young','middle','older')

# determine categories
employee.survey$age.categories<-cut(age,breaks=age.thresholds,labels=age.labels,right=T)

# show data
head(employee.survey)

# assess result
class(age.categories)
unclass(age.categories)

# show original variables and category side by side
cbind(age,age.categories)


# === binning salary
# define catgeories
salary.thresholds<-c(0,1500,2500,4000)
salary.labels<-c('low','middle','high')

# determine categories
employee.survey$salary.categories<-cut(salary,breaks=salary.thresholds,labels=salary.labels,right=T)

# show data
head(employee.survey)



# === Assessing the dependencies
summary(table(age.categories,gender))

# for CramersV load LSR library
library(lsr)
cramersV(table(age.categories,gender))

summary(table(employee.survey$salary.categories,gender))
cramersV(table(employee.survey$salary.categories,gender))


summary(table(employee.survey$motivation,gender))
cramersV(table(employee.survey$motivation,gender))



# === t-Tests
t.test(age~gender,paired=FALSE,var.equal=TRUE)
t.test(salary~gender,paired=FALSE,var.equal=TRUE)
t.test(motivation~gender,paired=FALSE,var.equal=TRUE)





# DOES NOT WORK - Motivation has more than two values! -> ANOVA necessary
t.test(age~motivation,paired=FALSE,var.equal=TRUE)

detach(employee.survey)
