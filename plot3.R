raw_data <- read.csv("data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
sub <- subset(raw_data, Date %in% c("1/2/2007", "2/2/2007"))
data <- within(sub, {
  DateX <- as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
  Date <- as.Date(Date, format = "%d/%m/%Y")
  DTS <- paste(Date, Time)
  DateTime <- strftime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
})[,c("DateTime","Date","DateX","DTS","Sub_metering_1","Sub_metering_2","Sub_metering_3")]

png(filename="plot3.png")

# Plot lines and frame
plot(data$DateX, data$Sub_metering_1,
     type="l",
     xlim=c(min(data$DateX), max(data$DateX)),
     ylim=c(0, max(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))),
     ylab="Energy sub metering", xlab="")
lines(data$DateX, data$Sub_metering_2, col="Red")
lines(data$DateX, data$Sub_metering_3, col="Blue")

# Plot legend
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("Black","Red","Blue"),
       pch = "_", cex=1.5)

dev.off()
