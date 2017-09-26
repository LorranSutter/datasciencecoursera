library(lattice)
library(datasets)

xyplot(Ozone ~ Wind, data = airquality)  # Basic scatter plot

airquality <- transform(airquality, Month = factor(Month))        # Transform Month in factor
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))  # Ozone versus Wind by Month

# Lattice graphics functions return an object of class trellis
p <- xyplot(Ozone ~ Wind, data = airquality)  # Nothing happens
print(p)                                      # Print plot

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)        # Crazy expression
f <- factor(f, lables = c("Group 1", "Group 2")) # Error: unused argument ????
xyplot(y ~ x | f, layout = c(2,1))               # Plot y versus x by factor f

xyplot(y ~ x | f, panel = function(x,y,...){     # Custom panel function
  panel.xyplot(x,y,...)                          # First call default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2)           # Add horizontal line
})
