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