myDtFormat = "%d/%m/%Y"
f <- "household_power_consumption.txt"

# Read file
df = read.table(file="household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                colClasses = c(rep("character",2),rep("numeric",7)))

df$Date <- as.Date(df$Date, format = myDtFormat)            # Convert date
dates <- df$Date >= "2007/02/01" & df$Date <= "2007/02/02"  # Filter right dates    
df2 <- df[dates,]                                           # Separetes only dates
df2$Date <- as.POSIXct(paste(df2$Date, df2$Time))           # Convert to POSIXct

png(file = "plot3.png")
plot(df2$Date, 
     df2$Sub_metering_1, 
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = "")
lines(df2$Date, 
      df2$Sub_metering_2, 
      col = "red")
lines(df2$Date, 
      df2$Sub_metering_3,
      col = "blue")
legend("topright", legend = c("Sub_metering_1",
                              "Sub_metering_2",
                              "Sub_metering_3"), 
       col = c("black","red","blue"),
       lty = 1)
dev.off()