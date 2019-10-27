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

#Plot 1 "Global Active Power"
hist(as.numeric(df$Global_active_power), main = "Global Active Power", 
   xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

#Create and save histogram as PNG
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(df$Global_active_power), main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")