raw_data <- read.csv("data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
sub <- subset(raw_data, Date %in% c("1/2/2007", "2/2/2007"))
data = within(sub, {
  Date <- as.Date(Date, format = "%d/%m/%Y")
  DateTime <- strftime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
})

png(filename="plot1.png")
hist(data$Global_active_power,
     main="Global Active Power", 
     breaks = 16,
     col="Red",
     ylab="Frequency",
     xlab="Global Active Power (kilowatts)")
dev.off()
