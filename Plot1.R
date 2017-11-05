###Plot1.R
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
#display on screen...I made my chart blue for the side-by-side and to know which one was mine
#histogram with x axis global acive power in kw
hist(PowerDataUse$Global_active_power,col="blue",main="Global Active Power",xlab="Global Active Power (kilowatts)")
#display on file device called Plot1.png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
