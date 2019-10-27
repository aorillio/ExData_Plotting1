# Load the data set
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

# Read data

power <- read.table(file = "household_power_consumption.txt", header = TRUE, colClasses = "character", sep = ";", na = "?")

#Adjust Date & Filter for timepoints
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
df <- power[(power$Date == "2007-02-01") | (power$Date == "2007-02-02"),]
df <- transform(df, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#1
plot(df$timestamp, df$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power")

#2
plot(df$timestamp, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#3
plot(df$timestamp, df$Sub_metering_1, type = "l", xlab = " ", ylab = "Energy Sub metering")
points(df$timestamp, df$Sub_metering_2, type = "l", col = "red")
points(df$timestamp, df$Sub_metering_3, type = "l", col = "blue")

legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

#4
plot(df$timestamp, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
