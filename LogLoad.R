## Load GarminConnect Log


rm(lg)
setwd("D:\\Personal\\Projects\\R\\Running")
lg = read.table("Garmin Connect Log - 2015-06-07_3.csv", sep=",", header=TRUE)
lg

summary(lg)
colnames(lg)

table(lg$doc_type)
table(lg$printer_name)
req = as.data.frame(table(lg$job_date))
library("ggplot2")
qplot(lg$doc_type)

sp <- ggplot(lg, aes(x=lg$doc_type, y=lg$user_id))
sp + geom_point()

## what is a probability that next printed document will be SI?

## how this probability changes with time of a day? (per hour)
