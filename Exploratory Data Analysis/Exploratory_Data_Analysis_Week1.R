# ----- Plotting System in R -----
# Base: "artist's palette" model
library(datasets)
data("cars")
with(cars, plot(speed, dist))

# Lattice: entire plot specified by on function; conditioning
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

# ggplot2: Mixes elements of Base and Lattice
install.packages("ggplot2")
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)


# ----- Base Plotting System (part 1) -----
library(datasets)

hist(airquality$Ozone) # histogram

with(airquality, plot(Wind, Ozone)) # scatter

airquality <- transform(airquality, Month = factor(Month))
# boxplot (min, 1st quart, mean, 3rd quart, max)
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

# Base Graphics Parameters
# pch(plottoing  symbol), lty(line type), lwd(line width), col(color), xlab(x label), ylab(y label)

# par() function -> affect all plots in R section
# par("parameter") -> show default parameter
# las(axis label orientation), bg(background color), mar(margin size), oma(outer margin size), 
# mfrow(number of plot per row, row wise), mfcol(number of plots per column, column wise)


# ----- Base Plotting System (part 2) -----
# plot(scatter plot), lines(add line), points(add point), text(add text), title(add title)
# mtext(add arbitrary text to the margin), axis(add axis ticks/labels)

library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City") # add title

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City")) # add a title too
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))       # subset in blue

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York", type = "n"))   # type 'n' for no plotting
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))                # subset in blue
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))                 # outter subset in blue
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months")) # legend

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York", pch = 20))   # see ?points to see char 20
model <- lm(Ozone ~ Wind, airquality)                                                # create linear model
abline(model, lwd = 2)                                                               # line to represent lm

# multiple base plots
par(mfrow = c(1,2)) # Define 1 row and 2 columns
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0)) # Define 1 row and 3 columns and margins
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE) # add outer title
})


# ----- Base Plot Demonstration -----
example(points)  # Sequence of plots with points examples

x <- rnorm(100)
y <- rnorm(100)
plot(x,y, xlab = "Width", ylab = "Height", pch = 20)
title("Scatterplot")                                  # It is the same as put main param in plot
text(-2,-2, "Label")
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y~x)
abline(fit, lwd = 3, col = "red")

z <- rpois(100,2)
par(mfrow = c(2,2), mar = c(4,2,2,2))  # mfrow sets plots in rowwise
plot(x,y)
plot(x,z)
plot(y,x)
plot(z,x)

par(mfcol = c(2,2), mar = c(4,2,2,2)) # mfcol sets plots in colwise
plot(x,y)
plot(x,z)
plot(y,x)
plot(z,x)

par(mfrow = c(1,1))
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2,50, labels = c("Male", "Female"))
plot(x,y, type = "n")                                    # Make the plot, but do not show data
# It works like a sample of same date from Male and Female group
points(x[g == "Male"], y[g == "Male"], col = "green")    # Select first 25 samples
points(x[g == "Female"], y[g == "Female"], col = "blue") # Select last 25 samples


# ----- Graphics Devices in R (part 1) -----
library(datasets)
pdf(file = "myplot.pdf")                  # Open PDF device
with(faithful, plot(eruptions, waiting))  # Create plot and send it automatically to a file
title(main = "Old Faithful Geyser Data")  # Annotate plot
dev.off()                                 # Close the PDF file device

# Graphic file devices
# Vector formats
# pdf, svg (support animation and interactivity),
# win.metafile (only Windows), postscript (older format, .ps, .eps)

# Bitmap formats
# png, jpeg, tiff, bmp (native Windows bitmapped format)

# Multiple open graphics devices
# Plotting can only occur on one graphic device at a time
# Currently active graphics device can be found by calling dev.cur()
# Every opened device has an ID
# Change active graphic device with dev.set(ID)

# Copying plots
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser Data")
dev.copy(png, file = "geyserplot.png")   # Copy a plot to one device to another
dev.off()

with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser Data")
dev.copy2pdf(file = "geyserplot.pdf")    # Specific function to copy one device to PDF
dev.off()