# transfomr factors to time
lg$Start <- strptime(as.character(lg$Start),"%m/%d/%Y %H:%M:%S") # Convert to POSIXlt format
lg$Time <- as.difftime(as.character(lg$Time),"%H:%M:%S")
lg$End <- lg$Start + lg$Time

# transform factors to numerics
lg$Elevation.Gain <- as.numeric(levels(lg[,8])[lg[,8]]) # Elevation.Gain
lg$Avg.HR <- as.numeric(levels(lg[,11])[lg[,11]]) # Avg.HR
lg$Max.HR <- as.numeric(levels(lg[,12])[lg[,12]]) # Max.HR

#str(lg)

# select only running activities
lg1 <- lg[lg$Activity.Type == "Street Running",]

#summary(lg1)

# select runs between 3 and 4 miles
lg2 <- lg1[lg1$Distance > 3 & lg1$Distance < 4,]

summary(lg2)

