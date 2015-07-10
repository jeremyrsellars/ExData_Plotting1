raw_data <- read.csv("data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
sub <- subset(raw_data, Date %in% c("1/2/2007", "2/2/2007"))
data <- within(sub, {
  DateX <- as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
  Date <- as.Date(Date, format = "%d/%m/%Y")
  DTS <- paste(Date, Time)
  DateTime <- strftime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
})

png(filename="plot4.png")

# Plot lines and frame
par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,2,0))

# top-left -- Global Active Power
plot(data$DateX, data$Global_active_power, main = "Global Active Power Over Time",
     type="l",
     xlim=c(min(data$DateX), max(data$DateX)),
     ylim=c(0, max(data$Global_active_power)),
     ylab="Global Active Power (kilowatts)", xlab="")

# top-right -- Voltage
plot(data$DateX, data$Voltage, main = "Voltage over time",
     type="l",
     xlim=c(min(data$DateX), max(data$DateX)),
     ylim=c(min(data$Voltage), max(data$Voltage)),
     ylab="Voltage", xlab="")

# bottom-left -- Energy sub metering
plot(data$DateX, data$Sub_metering_1, main = "Energy Sub Metering Over Time",
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
       bty = "n",
       pch = "_")

# bottom-right -- Global reactive power
plot(data$DateX, data$Global_reactive_power, main = "Global Reactive Power Over Time",
     type="l",
     xlim=c(min(data$DateX), max(data$DateX)),
     ylim=c(min(data$Global_reactive_power), max(data$Global_reactive_power)),
     ylab="Global reactive power", xlab="")

dev.off()
