plot1 <- function( SelectedData ){
  hist(SelectedData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
}

  
plot2 <- function( SelectedData, Timestamps, ylab = "Global Active Power (kilowatts)" ){
  plot(Timestamps, SelectedData$Global_active_power, type = "n", xlab = "", ylab = ylab )
  
  lines(Timestamps, SelectedData$Global_active_power)
}

plot3 <- function( SelectedData, Timestamps, bty='o' ){
  plot(Timestamps, SelectedData$Sub_metering_1, 
       type = "n", xlab = "", ylab = "Energy sub metering" )
  
  lines(Timestamps, SelectedData$Sub_metering_1, col = "black")
  lines(Timestamps, SelectedData$Sub_metering_2, col = "red" )
  lines(Timestamps, SelectedData$Sub_metering_3, col = "blue")
  legend("topright", lty = 1, cex = 0.95, bty = bty, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}

plot4 <- function( SelectedData, Timestamps ){
  plot(Timestamps, SelectedData$Voltage, type = "n", xlab = "datetime", ylab = "Voltage" )
  
  lines(Timestamps, SelectedData$Voltage)
}

plot5 <- function( SelectedData, Timestamps ){
  plot(Timestamps, SelectedData$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power" )
  
  lines(Timestamps, SelectedData$Global_reactive_power)
}
