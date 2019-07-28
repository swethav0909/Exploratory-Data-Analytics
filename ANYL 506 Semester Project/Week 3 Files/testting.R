#Read in your data
library(readr)
ozone <- read_csv("US EPA data 2017.csv", col_types = "ccccinnccccccncnncccccc")
View(ozone)
names(ozone) <- make.names(names(ozone))
#
nrow(ozone)
ncol(ozone)
str(ozone)
#
head(ozone[, c(6:7, 10)])
#
tail(ozone[, c(6:7, 10)])
#
table(ozone$Sample.Duration)
table(ozone$State.Code)
table(ozone$POC)
library(dplyr)
#
filter(ozone, State.Code == "2", Site.Num =="0010") %>% 
select(Sample.Duration, POC)
# 

filter(ozone, POC=="2", County.Code=="003", Site.Num =="0010") %>%
select(State.Code,Datum) %>% as.data.frame
# 
select(ozone, State.Code) %>% unique %>% nrow
#
unique(ozone$State.Code)
#
#
summary(ozone$Observation.Count)
#
quantile(ozone$Observation.Count, seq(0, 1, 0.25))
#
#
ranking <- group_by(ozone, State.Code, County.Code) %>%
summarize(ozone = mean(Observation.Count)) %>%
as.data.frame %>%
arrange(desc(ozone))
#
head(ranking, 10)
# 
tail(ranking, 10)
#
filter(ozone, State.Code == "01" & County.Code == "003") %>% nrow

filter(ozone, State.Code == "01" & County.Code == "003") %>%
summarize(ozone = mean(Observation.Count))

#
#
set.seed(10234)
N <- nrow(ozone)
idx <- sample(N, N, replace = TRUE)
ozone2 <- ozone[idx, ]
View(ozone2)
#
ranking2 <- group_by(ozone2, State.Code, County.Code) %>%
summarize(ozone = mean(Observation.Count)) %>%
as.data.frame %>%
arrange(desc(ozone))
# 
ranking2 
#
cbind(head(ranking, 10),head(ranking2, 10))
#
cbind(tail(ranking, 10),tail(ranking2, 10))


