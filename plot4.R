plot4 <- function(data) {
    
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
    data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
    unlink(temp)
    
    data <- na.omit(data)    
    data$Date <- gsub("\\/", "-", data$Date)
    data$Date <- as.Date(as.character(data$Date), "%d-%m-%Y")    
    data <- subset(data, Date %in% as.Date(c("2007-02-02", "2007-02-01")))
    data$DateTime <- as.POSIXct(paste(data$Date, data$Time))
    
    plot_colors <- c("black","red","blue")
    max_y <- max(data[c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")])
    
    png(file="plot4.png", width=680, height=680)
    par(mfrow=c(2,2))
    par(mar=c(5.1, 4.1, 4.1, 2.1))
    plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    
    plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
    plot(data$DateTime, data$Sub_metering_1, type="l", col=plot_colors[1], ylim=c(0,max_y), xlab="", ylab="Energy sub metering")    
    lines(data$DateTime, data$Sub_metering_2, type="l", col=plot_colors[2])    
    lines(data$DateTime, data$Sub_metering_3, type="l", col=plot_colors[3])
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=plot_colors, lwd=1, bty="n")
    
    plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
    dev.off()
}