raw_data <- read.csv("data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
sub <- subset(raw_data, Date %in% c("1/2/2007", "2/2/2007"))
data <- within(sub, {
  DateX <- as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
  Date <- as.Date(Date, format = "%d/%m/%Y")
  DTS <- paste(Date, Time)
  DateTime <- strftime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
})[,c("DateTime","Date","DateX","DTS","Global_active_power")]

png(filename="plot2.png")
plot(data$DateX, data$Global_active_power,
     type="l",
     xlim=c(min(data$DateX), max(data$DateX)),
     ylim=c(0, max(data$Global_active_power)),
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
