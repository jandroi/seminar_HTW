library(datasets)
library(ggplot2)

# === Clean Up Workspace
# rm(list = ls())

# Show data
head(esoph)

#show data in first column
esoph[1,]
esoph$agegp

attach(esoph)

# show data
agegp

# determine frequencies
table(agegp)
table(tobgp)

# based on frequencies create a barchart
barplot(table(tobgp))

# improve the barchart
barplot(table(tobgp), col = 2)
barplot(table(tobgp), main="Distribution of Tobacco Consumption", col = 2)
barplot(table(alcgp), main="Distribution of Alcohol consumption", col = 2)

# === Univariate stats using ggplot
# aes = Aesthetic mappings describe how variables
# are mapped to visual properties (aesthetics)
# See also https://www.rdocumentation.org/packages/ggplot2/versions/2.2.1/topics/aes
ggplot(esoph, aes(tobgp)) +  geom_bar()

# === dependency analysis
plot(agegp,tobgp)

# crosstable
table(agegp,tobgp)

# chi square test of independence
my.table<-table(agegp,tobgp)
my.table
summary(my.table)

# or alternatively
chisq.test(agegp,tobgp)

library(lsr)
cramersV(agegp,tobgp)

# age vs alcohol
plot(agegp,alcgp)
my.table<-table(agegp,alcgp)
my.table
summary(my.table)
cramersV(agegp,alcgp)

# alcohol vs tobacco
plot(alcgp,tobgp)
my.table<-table(alcgp, tobgp)
my.table
summary(my.table)
cramersV(alcgp,tobgp)