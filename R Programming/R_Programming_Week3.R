# ----- lapply -----
# lapply(list, FUN, ...) -> return a list
# ... for other arguments to the function

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- 1:4
lapply(x, runif, min = 0, max = 10) # uniform distribution in range (0,10)

x <- list(a = matrix(1:4,2,2), b = matrix(1:6,3,2))
lapply(x, function(elt) elt[,1]) # anonymous function that extracts first column from matrices


# ----- sapply -----
# simplify lapply return
# sapply(list, FUN, ...) -> variable return
# ... for other arguments to the function

x <- list(a = 1:5, b = rnorm(10))
sapply(x, mean) # returns a vector insted of a list


# ----- vapply -----
# simplify lapply return and specify the return if it is possible
# vapply(list, FUN, FUN.VALUE, ...) -> variable return
# FUN.VALUE -> specify return type
# ... for other arguments to the function

x <- list(a = 1:5, b = rnorm(10))
vapply(x, mean, numeric(1)) # returns a vector insted of a list


# ----- apply -----
# apply FUN in dimensions defined by MARGIN
# apply(list, MARGIN, FUN, ...)
# ... for other arguments to the function

x <- matrix(rnorm(200),20,10)
apply(x,2,mean)
apply(x,1,sum)

# rowSums() = apply(x,1,sum)
# rowMeans() = apply(x,1,mean)
# colSums() = apply(x,2,sum)
# colMeans() = apply(x,2,mean)

a <- array(rnorm(2 * 2 * 10), c(2,2,10))
apply(a,c(1,2),mean)  # keep 1st and 2nd dimensions
rowMeans(a, dims = 2)


# ----- mapply -----
# apply FUN in multiple set of arguments
# mapply(FUN, ..., maisUmasCoisaAqui)

list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
# same as
mapply(rep,1:4,4:1)

noise <- function(n, mean, sd){
  rnorm(n,mean,sd)
}
mapply(noise,1:5,1:5,2)
# same as
list(noise(1,1,2),noise(2,2,2),noise(3,3,2),noise(4,4,2),noise(5,5,2))


# ----- tapply ----- nao entendir
# apply FUN over subset of a vector corresponding to the factor
# tapply(X, INDEX, FUN = NULL, ..., simplify = TRUE)
# X and INDEX must have same dimension
# INDEX -> factor or a list of factors
# ... for other arguments to the function

x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10)    # 1 1  ... 1 1 2 2 ... 2 2 3 3 ... 3 3
tapply(x,f,mean)


# ----- split -----
# split vector x acoording factor f
# split(x, f, , drop = FALSE, ...)
# ... for other arguments to the function

x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10)
split(x,f)

lapply(split(x,f),mean)
# Same as
tapply(x,f,mean)

library(datasets)
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone","Solar.R","Wind")], na.rm = TRUE))
sapply(s, function(x) colMeans(x[, c("Ozone","Solar.R","Wind")], na.rm = TRUE))

# split in multiple levels
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
# interaction(f1,f2)
str(split(x,list(f1,f2), drop = TRUE)) # drop empty levels