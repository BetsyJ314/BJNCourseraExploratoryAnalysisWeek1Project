###Plot4.R
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
#need to order date-time asc
PowerDataUse$datetimestamp <- strptime(paste(PowerDataUse$Date, PowerDataUse$Time), "%Y-%m-%d %H:%M:%S")
PowerDataUse$datetimestamp <- as.POSIXct(PowerDataUse$datetimestamp)
#check new column worked
str(PowerDataUse)
#display on screen
#multiple base plots:
#a) global active power over a time horizon
#b) voltage over a time horizon
#c) sub-metering overa time horizon
#d) global reactive power over a time horizon
#set up graph display structure (all in one row or 2x2,etc.)
par(mfrow=c(2,2))
with(PowerDataUse, {
  plot(PowerDataUse$datetimestamp,PowerDataUse$Global_active_power,type = "l", xlab="Feb 1 2007 Through Feb 2 2007", ylab="Global Active Power (kilowatts)")
  plot(PowerDataUse$datetimestamp,PowerDataUse$Voltage,type = "l", xlab="Feb 1 2007 Through Feb 2 2007", ylab="Voltage")
  plot(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_1,type = "l",xlab="Feb 1 2007 Through Feb 2 2007",ylab="Sub-Metering Watt Hour of Active Energy")
  with(PowerDataUse,lines(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_2,type = "l",col="red"))
  with(PowerDataUse,lines(PowerDataUse$datetimestamp,PowerDataUse$Sub_metering_3,type = "l",col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(PowerDataUse$datetimestamp,PowerDataUse$Global_reactive_power,type = "l", xlab="Feb 1 2007 Through Feb 2 2007", ylab="Global Reactive Power (kilowatts)")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()