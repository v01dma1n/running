## Load GarminConnect Log


rm(lg)
lg = read.table("./Data/Garmin Connect Log - 2015-06-07_3.csv", sep=",", header=TRUE)
lg

summary(lg)
colnames(lg)

