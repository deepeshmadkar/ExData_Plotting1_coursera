setwd("/Learnings/Rprogrammings/exp-ds/week1/ExData_Plotting1-master")

# checking if data directory exists if not creating it
if(!file.exists("./data")){
  dir.create("data") 
}

# setting the download url and fileName variable to save in data directory
downloadUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "./data/household_power_consumption.zip"

# checking if file exists or already downloaded, if not it will download
if (!file.exists(fileName)){
  download.file(downloadUrl, fileName, method="curl")
}

# checking if file exists, prior unzip 
# ?unzip - to check the required params for unzipping
if (!file.exists("./data/household_power_consumption.txt")) { 
  unzip(zipfile = fileName, exdir = "./data")
}

# Loading the data
globalActivePower <- read.table("./data/household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";", na.strings="?", colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric","numeric","numeric", "numeric"))

# Subsetting the data using grep
gcpSubsetData <- globalActivePower[grep("^[1,2]/2/2007", globalActivePower$Date),]

# Merging & Creating DateTime
gcpSubsetData$DateTime <- paste(gcpSubsetData$Date, gcpSubsetData$Time)
gcpSubsetData$DateTime <- strptime(gcpSubsetData$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Output Device
png("./plot3.png", width=504, height=504)

# Adding line graph for DateTime vs Sub metering 1
plot(gcpSubsetData$DateTime, gcpSubsetData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

# Adding line graph for DateTime vs Sub metering 2 in red
lines(gcpSubsetData$DateTime, gcpSubsetData$Sub_metering_2, type = "l", col = "red" )

# Adding line graph for DateTime vs Sub metering 3 in blue
lines(gcpSubsetData$DateTime, gcpSubsetData$Sub_metering_3, type = "l", col = "blue" )

# Adding legend to graph
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

title(m = "Plot 3")

# Turning off the Output device
dev.off()