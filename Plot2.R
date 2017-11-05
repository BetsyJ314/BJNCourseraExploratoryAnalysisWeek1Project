###Plot2.R
library(data.table)

#Note that in this dataset missing values are coded as ?.
PowerData<-read.table("household_power_consumption.txt",sep=';', header=FALSE, na.strings="?", stringsAsFactors=FALSE, skip = 1)
#Instructor: You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions.
names(PowerData) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#What are the current date and time column classes?
str(PowerData)
#filter for the timeframe needed....1/2/2007 and 2/2/2007
#convert date
PowerData$Date <- as.Date(PowerData$Date, format = "%d/%m/%Y")
PowerDataUse<-subset(PowerData,PowerData$Date =="2007-02-01"|PowerData$Date =="2007-02-02")
str(PowerDataUse)
#display on screen
#line graph with x axis = time and y axis = global acive power in kw
#need to order date-time asc
PowerDataUse$datetimestamp <- strptime(paste(PowerDataUse$Date, PowerDataUse$Time), "%Y-%m-%d %H:%M:%S")
PowerDataUse$datetimestamp <- as.POSIXct(PowerDataUse$datetimestamp)
#check new column worked
str(PowerDataUse)
#initital plot
plot(PowerDataUse$datetimestamp,PowerDataUse$Global_active_power)
#as line instead of dots
plot(PowerDataUse$datetimestamp,PowerDataUse$Global_active_power,type = "l")
#with labels
plot(PowerDataUse$datetimestamp,PowerDataUse$Global_active_power,type = "l", xlab="Feb 1 2007 Through Feb 2 2007", ylab="Global Active Power (kilowatts)")
#display on file device called Plot2.png
dev.copy(png, file="plot2.png", height=480, width=480)
title(main="Global Active Power Over a Time Horizon")
dev.off()