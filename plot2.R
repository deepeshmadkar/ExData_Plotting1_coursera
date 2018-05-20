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
png("./plot2.png", width=504, height=504)

# Adding line graph for DateTime vs Global actice power
plot(gcpSubsetData$DateTime, gcpSubsetData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")

title(m = "Plot 2")

# Turning off the Output device
dev.off()
