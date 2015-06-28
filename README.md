Impact of air temperature on runner's performance
=================================================


#Question
I am a casual runner and love data.  Having Garmin GPS watch allowed me to collect a lot of data about my runs.  
Since I am on a heavy side, my body does not respond well to higher temperatures. 
My 'God of Running', Jeff Galloway discusses pace adjustments for running races (see Resources below).  
**How does my running data reflect performance decrease with raisng temperature?**

##Account for Heat by Jeff Galloway
http://www.fleetfeetwinston-salem.com/training/resources/heat-pace  
_The hot and sticky days of summer are here. Make sure that you are making some adjustments in your running. Most runners begin to slow down at 55 degrees and start suffering at 65 degrees. Of course, the body can adapt to heat stress and push the threshold up a bit, but you usually can't run as fast on a 75 degee day as on a 45 degree one. High humidity is also a major problem. It's like a wet blanket; it doesn't allow much evaporation or perspiration and your body heat builds up.
If you try to run too hard in hot or humid conditions you'll hit "the wall" sooner than expected. Trying to maintain a goal pace in heat is like going out too fast early in the race. Temperatures generally increase hour by hour; therefore you must adjust your pace for the temperature expected at the end of the race._  
Adjusting Race Pace for Heat:  
Estimated temperature at finish - Slower than goal pace - 8 min mile becomes...  
* 55-60 degrees - 1% - 8:05  
* 60-65 degrees - 3% - 8:15  
* 65-70 degrees - 5% - 8:25  
* 70-75 degrees - 7% - 8:35  
* 75-80 degrees - 12% - 8:58  
* 80-85 degrees - 20% - 9:35  
* Above 85 degrees - Forget it... run for fun  
Note: This chart is based upon my own experience in the heat and talking to other runners. It has no scientific verification.  
#Study Design
##Assumptions
* The analysis will be performed on run by run basis.  
* Only single temperature point will be associated with a run.  
* For temperature retrieval, end time will be used (as in Galloway's data).  
* The temperature will be retrieved for weather station located 15 miles from usual locaction of the runs.  
* From the pool of all runs, only training, 3-4 mile runs will be considered.  Races and long runs will be excluded.  
* The runs will be selected only from ones on realively flat course.  Garmin Elevation.Gain < 100ft
* Performance increase due to training level must be factored.  


#Challenges

##Is it enough data?  
Effectively I will be looking at around 100 observations.  As long I won't try to draw to generalized conclusion and focusing on my perpormance, it should be OK.  

##Running log does not have temperature data  
The the temperature data is not provided by Garmin Connect website.  In order to corelate running performance with air temperature, hourly climate data must be retrieved.  One available source is NOAA isd-history (ftp://ftp.ncdc.noaa.gov/pub/data/noaa/isd-history.csv).  
The temperature data is available in hourly intervals.  

##Factoring training level
The number of runs per week varied over time.  I assume, that with more runs my performance got better and could affect the analysis.  I need to factor for performance increase due to traing leve.  

#Code Book

##Run history from Garmin Connect
..  

##Hourly temperature from NOAA
..   


#Open questions
* What is the optimal temperature for running? From Galloway'd data looks like range between 50F and 55F.  
* Galloway's numbers don't show values below 55F. Does running at 45F give advantage over 55F?  
* When an athlete runs more frequently, his or her performance increase due to exercise. How to factor for training level?  

