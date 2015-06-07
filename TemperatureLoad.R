setwd("D:\\Personal\\Projects\\R\\Running")
file <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/isd-history.csv"
repeat {
  try(download.file(file, "data/isd-history.csv", quiet = TRUE))
  if (file.info("data/ish-history.csv")$size > 0) {
    break
  }
}
st <- read.csv("data/isd-history.csv")
dim(st)
names(st)  

names(st)[c(3, 9)] <- c("NAME", "NAME")
#st <- st[, -5]
#st <- st[st$CTRY == "US", ]

st[st$ICAO == "KSMQ",]
#        USAF  WBAN               NAME CTRY ICAO    LAT     LON ELEV.M.     ELEV      END
#18077 722247 54785   SOMERSET AIRPORT   US KSMQ 40.624 -74.669      32 20060101 20150513
#18078 722247 99999           SOMERSET   US KSMQ 40.633 -74.667      32 20050217 20051231
#19188 724104 99999 SOMERSET ARPT ASOS   US KSMQ 40.633 -74.667      32 19990114 20050208

#system("gunzip -r data/raw", intern = FALSE, ignore.stderr = TRUE)

files <- list.files("data/raw")


column.widths <- c(4, 6, 5, 4, 2, 2, 2, 2, 1, 6,7, 5, 5, 5, 4, 3, 1, 1, 4, 1, 5, 1, 1, 1, 6, 1, 1, 1, 5, 1, 5, 1, 5, 1)
#stations <- as.data.frame(matrix(NA, length(files),6))
#stations
#names(stations) <- c("USAFID", "WBAN", "YR", "LAT","LONG", "ELEV")



for (i in 1:length(files)) {
  #data <- read.fwf(paste("data/raw/", files[i], sep = ""), column.widths)
  data <- read.fwf(paste("data/raw/", files[1], sep = ""), column.widths)
  data <- data[, c(2:8, 10:11, 13, 16, 19, 29, 31, 33)]
  names(data) <- c("USAFID", "WBAN", "YR", "M","D", "HR", "MIN", "LAT", "LONG", "ELEV", "WIND.DIR", "WIND.SPD", "TEMP", "DEW.POINT", "ATM.PRES")
  data$LAT <- data$LAT/1000
  data$LONG <- data$LONG/1000
  data$WIND.SPD <- data$WIND.SPD/10
  data$TEMP <- data$TEMP/10
  data$DEW.POINT <- data$DEW.POINT/10
  data$ATM.PRES <- data$ATM.PRES/10
#  write.csv(data, file = paste("data/csv/", files[i], ".csv", sep = ""), row.names = FALSE)
  if (i == 1) 
    allweather <- data
  else
    allweather <- rbind(allweather, data)
}
