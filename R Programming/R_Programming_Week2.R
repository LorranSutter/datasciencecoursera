# ----- Control Structures - If-else -----
if(1 < 2){
  # Do something
}else if(1 > 2){
  # Do something
}else{
  # Do something
}

x <- 1
if(x > 3){
  y <- 10
}else{
  y <- 0
}
# /\ same \/
y <- if(x > 3){
  10
}else{
  0
}

# ----- Control Structures - For loops -----
for(i in 1:10){
  print(i)
}

x <- c("a","b","c","d")

for(i in 1:4)
  print(x[i])
# /\ same \/
for(i in seq_along(x)){
  print(x[i])
}
# /\ same \/
for(letter in x){
  print(letter)
}
# /\ same \/
for(i in 1:4) print(x[i])

x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))){  # seq_len like range in Python
  for(j in seq_len(ncol(x))){
    print(x[i,j])
  }
}


# ----- Control Structures - While loops -----
count <- 0
while(count < 10){
  print(count)
  count <- count + 1
}


# ----- Control Structures - Repeat, Next, Break -----
x0 <- 1
tol <- 1e-8

repeat{
  x1 <- computeEstimate()
  
  if(abs(x1-x0) < tol){
    break
  }else{
    x0 <- x1
  }
}

for(i in 1:100){
  if(i <= 20){
    ## Skip the first 20 itereations
    next
  }
}


# ----- Functions -----
# Is recommended create functions in separete and individual files. I don't know why
add2 <- function(x,y){
  x + y
}

above10 <- function(x){
  use <- x > 10
  x[use]
}

above <- function(x, n = 10){ # Default value
  use <- x > n
  x[use]
}

columnmean <- function(y, removeNA = TRUE){
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc){
    means[i] <- mean(y[, i], na.rm = removeNA)
  }
  means
}

# ... to extend another function
myplot <- function(x,y,type = "l", ...){
  plot(x,y,type = type, ...)
}

# ... to say the number of arguments is not determinated
# In these cases, the arguments must be named so as to not missmatch
args(mean)
#function (..., sep = " ", collapse = NULL) 
