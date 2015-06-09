# Hourly weather load script from NOAA
# Helper script for retrieving hourly weather data.
# This script will not execute automatically since it requires some external operations.


setwd("D:\\Personal\\Projects\\R\\Running")

# 1. Determine USAF adn WBAN id of Somerset airport
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

st[st$ICAO == "KSMQ",]
#        USAF  WBAN               NAME CTRY ICAO    LAT     LON ELEV.M.     ELEV      END
#18077 722247 54785   SOMERSET AIRPORT   US KSMQ 40.624 -74.669      32 20060101 20150513
#18078 722247 99999           SOMERSET   US KSMQ 40.633 -74.667      32 20050217 20051231
#19188 724104 99999 SOMERSET ARPT ASOS   US KSMQ 40.633 -74.667      32 19990114 20050208

#system("gunzip -r data/raw", intern = FALSE, ignore.stderr = TRUE)

# 2. Download files from ftp://ftp.ncdc.noaa.gov/pub/data/noaa/ to .tmp folder
# ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2015/722247-54785-2015.gz
# ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2014/722247-54785-2014.gz
# ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2013/722247-54785-2013.gz

# 3. Uncompress the data to data/raw/ folder
# 722247-54785-2015
# 722247-54785-2014
# 722247-54785-2013

# 4. Process the files one a time and merge
files <- list.files("data/raw/")

column.widths <- c(4, 6, 5, 4, 2, 2, 2, 2, 1, 6,7, 5, 5, 5, 4, 3, 1, 1, 4, 1, 5, 1, 1, 1, 6, 1, 1, 1, 5, 1, 5, 1, 5, 1)

for (i in 1:length(files)) {
  data <- read.fwf(paste("data/raw/", files[i], sep = ""), column.widths)
  data <- data[, c(2:8, 10:11, 13, 16, 19, 29, 31, 33)]
  names(data) <- c("USAFID", "WBAN", "YR", "M","D", "HR", "MIN", "LAT", "LONG", "ELEV", "WIND.DIR", "WIND.SPD", "TEMP", "DEW.POINT", "ATM.PRES")
  data$LAT <- data$LAT/1000
  data$LONG <- data$LONG/1000
  data$WIND.SPD <- data$WIND.SPD/10
  data$TEMP <- data$TEMP/10
  data$DEW.POINT <- data$DEW.POINT/10
  data$ATM.PRES <- data$ATM.PRES/10
  if (i == 1) 
    allweather <- data
  else
    allweather <- rbind(allweather, data)
} # for

# 5. Save the output of hourly weather data
write.csv(allweather, file = paste("data/csv/", "WeatherData.csv", sep = ""), row.names = TRUE)

# 