library(dplyr)
people <- read.csv('people.csv')
countries <- read.csv('countries.csv')

people %>% head()

countries %>% head()


people %>% inner_join(countries, by= c('c_id' = 'country_id'))
