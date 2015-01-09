##Script producing time series plot of active power consumption of household
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

#plot time series graph
png('plot2.png',width=480,height=480,units="px",pointsize=12)
plot(data$Date,data$Global_active_power/1000,"l",cex.lab=1,cex.axis=1,xlab="",ylab="Global Active Power (kilowatts)",xaxt="n")
axis(1,at=c(data$Date[1],data$Date[1440],data$Date[2880]),labels=c("Thu","Fri","Sat"))
dev.off()
