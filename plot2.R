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

#Plot 2 
png(filename = "plot2.png", width = 480, height = 480)

plot(df$timestamp, df$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)")

dev.off()

