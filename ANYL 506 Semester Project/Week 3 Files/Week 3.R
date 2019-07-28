#Topics Covered in the week 3 Code file are as follows:
#Exploratory Data Analysis
#Instructions for EDA by using various functions


#This code is used to load and install the package readr
library(readr)
#This code is used to read csv files with large data
ozone <- read_csv("US EPA data 2017.csv",col_types = "ccccinnccccccncnncccccc")
#Lists the names of the columns
names(ozone) <- make.names(names(ozone))
names(ozone)
#To find the number of rows
nrow(ozone)
#To find the number of columns
ncol(ozone)
#This code helps in examinig the classes of each of the column listed in the dataset. That is, to see the structure
str(ozone)
#To look at the top of our data 
head(ozone[, c(6:7, 10)])
#Lists the bottom of our data
tail(ozone[, c(6:7, 10)])
#Table gives the result in tabular format for the total counts at each combination of factor levels.
table(ozone$Units.of.Measure)

library(dplyr)
library(tidyverse)
ozone<-tbl_df(ozone)
#This code is to select rows/cases where conditions given are true
filter(ozone, State.Code == "34", Site.Num =="2004") %>% 
  select(Sample.Duration, Parameter.Name)

#Select is used to keep the required vairables
select(ozone, state.region) %>% unique %>% nrow
#This code is to eliminate duplicate rows
unique(ozone$County.Code)
#Provides description on the selected object
summary(ozone$Sample.Duration)
#It is also called as percentile which explains how much of our data falls under a certain value
quantile(ozone$Observation.Count, seq(0, 1, 0.1))
#Group_by is used to convert the existing tbl to a a grouped tbl
ranking <- group_by(ozone, State.Code, County.Code) %>%
  summarize(ozone = mean(Sample.Duration)) %>%
  as.data.frame %>%
  arrange(desc(ozone))

#Head function returns the number of rows for a selected object we want to see 
head(ranking, 10)

#Returns the last number of rows (given) of a data frame
tail(ranking, 10)

filter(ozone, County.Code == "5" & State.Code == "4") %>% nrow

#To add new variables by preserving the existing one.
ozone <- mutate(ozone,  New.test = Observation.Count/2)

#More examples using the combinations
set.seed(10234)
N <- nrow(ozone)
idx <- sample(N, N, replace = TRUE)
ozone2 <- ozone[idx, ]
ranking2 <- group_by(ozone2, State.Code, County.Code) %>%
  summarize(ozone = mean(Sample.Duration)) %>%
  as.data.frame %>%
  arrange(desc(ozone))

#Helps in combining the dataframe by columns
cbind(head(ranking, 10),
        head(ranking2, 10))
