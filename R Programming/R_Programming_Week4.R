# ----- str function -----
# Good for quick examination
str(str)
str(lm)
str(ls)
x <- rnorm(100,2,4)
summary(x)
str(x)
f <- gl(40,10)
str(f)
library(airquality)
str(airquality)
s <- split(airquality,airquality$Month)
str(s)


# ----- Random Numbers -----
rnorm(1)    # Random normal distribution
dnorm(1)    # Normal probability density
pnorm(1)    # Normal cumulative distribution function
qnorm(1)    #

rpois(1,1)  # Random Poisson distribution
ppois(1,1)  # Poisson distribution function
set.seed(1) # Set seed what randomic is based


# ----- Simulating a Linar Model -----
# Simulating a linear model of y = b0 + b1*x + e
set.seed(20)
x <- rnorm(100)
e <- rnorm(100,0,2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

# What if x is binary? Like a gender
set.seed(20)
x <- rbinom(100,1,0.5)
e <- rnorm(100,0,2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

# Simulating a Poisson model where
# Y ~ Pisson(mu)
# log.mu = b0 + b1x
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100,exp(log.mu))
summary(y)
plot(x,y)


# ----- Random Sample -----
set.seed(1)
sample(1:10,4)
sample(letters,5)
sample(1:10)  # Permutation
sample(1:10, replace = TRUE) # Allow repeats