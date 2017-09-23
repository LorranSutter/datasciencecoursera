myDtFormat = "%d/%m/%Y"
f <- "household_power_consumption.txt"

# Read file
df = read.table(file="household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                colClasses = c(rep("character",2),rep("numeric",7)))

df$Date <- as.Date(df$Date, format = myDtFormat)            # Convert date
dates <- df$Date >= "2007/02/01" & df$Date <= "2007/02/02"  # Filter right dates    
df2 <- df[dates,]                                           # Separetes only dates
df2$Date <- as.POSIXct(paste(df2$Date, df2$Time))           # Convert to POSIXct

# Plot
png(file = "plot4.png")
par(mfrow = c(2,2))
with(df2, plot(Date,
               Global_active_power,
               xlab = "",
               ylab = "Global Active Power",
               type = "l"))

with(df2, plot(Date,
               Voltage,
               xlab = "datetime",
               ylab = "Voltage",
               type = "l"))

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
       lty = 1,
       bty = "n")

with(df2, plot(Date,
               Global_reactive_power,
               xlab = "datetime",
               type = "l"))
dev.off()