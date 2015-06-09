## Load GarminConnect Log


rm(lg)
setwd("D:\\Personal\\Projects\\R\\Running\\Data")
lg = read.table("Garmin Connect Log - 2015-06-07_3.csv", sep=",", header=TRUE)
lg

summary(lg)
colnames(lg)

