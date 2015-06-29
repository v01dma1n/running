## 
l.download <- function(filename = character(), rmt.path = character(), download.path = character()){
  rmt.file <- paste(rmt.path, filename, sep="")
  loc.file <- paste(download.path, filename, sep="")
  #  print(rmt.file)
  #  print(loc.file)
  repeat {
    try(download.file(rmt.file, loc.file, quiet = TRUE))
    if (file.info(loc.file)$size > 0) {
      break
    }
  }
}

## Function retrieves weather information from NOAA 
## for given airport withing provided years
hourly.weather.get <- function (icao = character(), 
                                years = c(),
                                download.path = "./data/download/",
                                rawdata.path = "./data/raw/") {

  rmt.path <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/"
  
  ## determine USAF and WBAN id of Somerset airport
  
  # get list of all airports
  l.download("isd-history.csv", rmt.path, download.path)
  st <- read.csv(paste(download.path, "isd-history.csv", sep=""))
  
  # The list of weather station looks like this:
  #        USAF  WBAN               NAME CTRY ICAO    LAT     LON ELEV.M.     ELEV      END
  #18077 722247 54785   SOMERSET AIRPORT   US KSMQ 40.624 -74.669      32 20060101 20150513
  #18078 722247 99999           SOMERSET   US KSMQ 40.633 -74.667      32 20050217 20051231
  #19188 724104 99999 SOMERSET ARPT ASOS   US KSMQ 40.633 -74.667      32 19990114 20050208
  
  # find row, which is for our airport 
  usaf.wban <- st[st$ICAO == icao & st$WBAN != '99999',c("USAF","WBAN")]
  # ToDo: what if we have more than one row here?
  
  for (year in years ) {
    # file name example "722247-54785-2014.gz"
    fn <- paste(usaf.wban[1, c("USAF")], "-", 
                usaf.wban[1, c("WBAN")], "-", 
                year, sep = "")  
    fn.gz <- paste(fn, ".gz", sep = "")  
    
    print(paste("Downloading file: ", fn))
    l.download(fn.gz, paste(rmt.path, year, "/", sep=""), download.path)

    print(paste("Uncompressing file: ", fn.gz))
    system(paste("gzip -d -k ", download.path, fn.gz, sep=""), intern = FALSE, ignore.stderr = TRUE)
    
    file.rename(paste(download.path, fn, sep=""), paste(rawdata.path, fn, sep=""))
    
    ## process the files one a time and merge
    column.widths <- c(4, 6, 5, 4, 2, 2, 2, 2, 1, 6,7, 5, 5, 5, 4, 3, 1, 1, 4, 1, 5, 1, 1, 1, 6, 1, 1, 1, 5, 1, 5, 1, 5, 1)
    
    data <- read.fwf(paste(rawdata.path, fn, sep = ""), column.widths)
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
  
  allweather
  # save the output of hourly weather data
  #write.csv(allweather, file = paste(rawdata.path, "WeatherData.csv", sep = ","), row.names = TRUE)
}