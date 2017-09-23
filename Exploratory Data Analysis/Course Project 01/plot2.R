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
png(file = "plot2.png")
with(df2, plot(Date,
              Global_active_power,
              xlab = "",
              ylab = "Global Active Power (kiliwatts)",
              type = "l"))
dev.off()