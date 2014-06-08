plot2 <- function() {
    #Load the dataset into R
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
    data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
    unlink(temp)
    
    #Clean the dataset
    data <- na.omit(data)    
    data$Date <- gsub("\\/", "-", data$Date)
    data$Date <- as.Date(as.character(data$Date), "%d-%m-%Y")    
    data <- subset(data, Date %in% as.Date(c("2007-02-02", "2007-02-01")))
    data$DateTime <- as.POSIXct(paste(data$Date, data$Time))
    
    #Plot "plot2" and save it as "plot2.png"
    png(file="plot2.png", width=580, height=580)
    par(mar=c(5.1, 4.1, 4.1, 2.1))
    plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    dev.off()
}