###Plot3.R
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
#line graph with x axis = time and y axis = each of the sub metering measues (3 of them)
#need to order date-time asc
PowerDataUse$datetimestamp <- strptime(paste(PowerDataUse$Date, PowerDataUse$Time), "%Y-%m-%d %H:%M:%S")
PowerDataUse$datetimestamp <- as.POSIXct(PowerDataUse$datetimestamp)
#check new column worked
str(PowerDataUse)
#initital plot
plot(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_1)
#as line instead of dots and axis labels
plot(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_1,type = "l",xlab="Feb 1 2007 Through Feb 2 2007",ylab="Sub-Metering Watt Hour of Active Energy")
#add line 2 for sub-metring 2 in the red color, 3 in blue
#with(PowerDataUse,lines(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_1),type = "l",col ="")
with(PowerDataUse,lines(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_2,type = "l",col="red"))
with(PowerDataUse,lines(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_3,type = "l",col="blue"))
#with legend
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
title(main="Sub-Metering Watt Hour of Active Energy Over a Time Horizon")
dev.off()