##Script producing four time series plots of power consumption of household
##appliances on February 1st and 2nd, 2007.
require(data.table)

#read and subset data
data <- read.table("./household_power_consumption.txt",header=TRUE,sep=";")
data <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

#convert date and time to right format, replace in data frame
datetime <- as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
data$Date <- datetime
data$Time <- NULL

#convert measurements from string to numeric value
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

##plot time series graphs to PNG file
png('plot4.png',width=480,height=480,units="px",pointsize=12)
par(mfrow=c(2,2))

#plot #1: global active power
plot(data$Date,data$Global_active_power/1000,"l",cex.lab=1,cex.axis=1,xlab="",ylab="Global Active Power (kilowatts)",xaxt="n")
axis(1,at=c(data$Date[1],data$Date[1440],data$Date[2880]),labels=c("Thu","Fri","Sat"))

#plot #2: voltage
plot(data$Date,data$Voltage,"l",cex.lab=1,cex.axis=1,xlab="datetime",ylab="Voltage",xaxt="n")
axis(1,at=c(data$Date[1],data$Date[1440],data$Date[2880]),labels=c("Thu","Fri","Sat"))

#plot #3: energy sub metering 
plot(data$Date,data$Sub_metering_1,"l",cex.lab=1,cex.axis=1,xlab="",ylab="Energy sub metering",xaxt="n",yaxt="n",ylim=c(0,35))
lines(data$Date,data$Sub_metering_2,col="RED")
lines(data$Date,data$Sub_metering_3,col="BLUE")
axis(1,at=c(data$Date[1],data$Date[1440],data$Date[2880]),labels=c("Thu","Fri","Sat"))
axis(2,at=c(0,10,20,30))
legend(legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),"topright",lwd=1,col=c("BLACK","RED","BLUE"),bty="n")

#plot #4: global reactive power
plot(data$Date,data$Global_reactive_power/1000,"l",cex.lab=1,cex.axis=1,xlab="datetime",ylab="Global_reactive_power",xaxt="n")
axis(1,at=c(data$Date[1],data$Date[1440],data$Date[2880]),labels=c("Thu","Fri","Sat"))

dev.off()
