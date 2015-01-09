##Script producing histogram of active power consumption of household
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

#plot histogram
png('plot1.png',width=480,height=480,units="px",pointsize=12)
hist(data$Global_active_power/1000,col="RED",cex.main = 1.25,cex.lab=1,cex.axis=1,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")
dev.off()
