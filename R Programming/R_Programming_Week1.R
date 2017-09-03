# ----- Library to teach R interactiverly -----
install.packages("swirl")
library(swirl)
swirl()

# ----- atomic classes, vectors and lists -----
x1 <- c(0.5,0.6)
x2 <- c(TRUE,FALSE)
x3 <- c(T,F)
x4 <- c("a","b","c")
x5 <- 9:29
x6 <- c(1+0i,2+4i)
x7 <- vector("numeric", length = 10)
y1 <- c(1.7,"a")
y2 <- c(TRUE,2)
y3 <- c("a",TRUE)
l1 <- list(1,"a",TRUE,1+4i)
l1
class(x1)
class(x2)
class(y1)
class(y2)
class(y3)
as.numeric(x1)
class(x7)
as.numeric(x7)
as.logical(x7)
as.logical(x1)
as.logical(x2)
as.character(x1)
as.numeric(x4)
as.complex(x4)


# ----- Matrices -----
m <- matrix(nrow = 2, ncol = 3) # Create a matrix full of NA
m
dim(m)
attributes(m)
m2 <- matrix(1:6, nrow = 2, ncol = 3)
m2
m2 <- matrix(1:6, nrow = 2, ncol = 2)
m2
m2 <- matrix(1:6, nrow = 2, ncol = 4) # Matrix must have dimension sub or multiple of data length
m2 <- matrix(1:6, nrow = 2, ncol = 3)
m2
m3 <- 1:10
dim(m)
dim(m3)
dim(m3) <- c(2,5) # Create a matrix with 2,5 dimension full of m3
m3
a <- 1:3
b <- 10:12
cbind(a,b) # Create matrix by column
rbind(a,b) # Create matrix by row


# ----- Factors -----
x8 <- factor(c("yes","yes","no","yes","no"))
x8
table(x8) # Show levels frequency in table
unclass(x8) # Show levels as numbers


# ----- Sort levels as passed parameters -----
x8 <- factor(c("yes","yes","no","yes","no"), levels = c("yes","no"))
x8
x9 <- c(1,2,NA,10,3)
is.na(x9)
is.nan(x9)
x10 <- c(1,2,NaN,NA,4)
is.na(x10) # A NA is a NaN
is.nan(x10)


# ----- Data frame -----
x11 <- data.frame(foo = 1:4, bar = c(T,T,F,F))
x11
nrow(x11)
ncol(x11)


# ----- Names -----
x12 <- 1:3
names(x12)
names(x12) <- c("foo","bar","norf") # Set names to vector x12
x12
names(x12)
x13 <- list(a = 1, b = 2, c = 3) # Create list with names a,b,c
x13
m4 <- matrix(1:4,nrow = 2, ncol = 2)
dimnames(m4) <- list(c("a","b"),c("c","d")) # Set names to matrix m4
m4

history(Inf) # Show history on the right
dir()
setwd("C:/Users/Lorran Sutter/datasciencecoursera")
savehistory('history')


# ----- Reading data -----
read.table()   # Read from a txt in table format
read.csv()     # Read cvs file
readlines()    # Read lines from a txt file
dget()         # Read R code files so as to reconstruct R object (single 1 object)
source()       # Read R code files (objects or code)
load()         # Read R code files
unserialize()  # Read an object in binary form


# ----- Writing data -----
write.table()   # Write from a txt in table format
writelines()    # Write lines from a txt file
dput()          # Write R code files so as to reconstruct R object (single 1 object)
dump()          # Same as dput, but to many objects (ex: dump(c("x","y"),"data.R"); x,y are obj)
save()          # Write R code files
unserialize()   # Write an object in binary form


# ----- Reading larger datasets (suggestion) -----
initial <- read.table("datatable.txt", nrow = 100)   # Read 100 rows from a txt in table format
classes <- sapply(initial,class) # Check what type of data initial is
tabAll <- read.table("datatable.txt", colClasses = classes) # Read knowing data type (read faster)


# ----- Reading other types of files (creating connections) -----
file()   # Like open() from python
gzfile() # Same as file but for gzip files
bzfile() # Same as file but for bzip2 files
url()    # Behave like open() from python but for urls
close()  # Like close() from python


# ----- Subetting - basics -----
vet <- c("a","b","c","d","a")  # Simple vector
vet[vet > "a"]                 # Select vet elements grater than "a"
logicalVet <- vet > "a"        # Create a logical vector
vet[logicalVet]                # Access vet elements corresponding logicalVets


# ----- Subetting - lists -----
l <- list(foo = 1:4, bar = 0.6, baz = "hello")
l[1]        # First element with name
l[[1]]      # Only the first element
l$bar       # Only second element
l[["bar"]]  # Only second element
l["bar"]    # Second element with name
l[c(1,3)]   # First and third element with name
l2 <- list(a = list(10,12,14), b = c(3.14,2.81))
l2[[c(1,3)]]  # Third a element from first l2 elment
l2[[1]][[3]]  # Third a element from first l2 elment
l2[[c(2,1)]]  # First a element from second l2 elment


# ----- Subetting - matrices -----
m <- matrix(1:6,2,3)
m[1,2]  # Element 1,2
m[2,1]  # Element 2,1
m[1,]   # All elements from first line
m[,2]   # All elements from second column
m[1,2, drop = FALSE]  # Element 1,2 as a matrix
m[1, , drop = FALSE]  # All elements from first line as a matrix


# ----- Subetting - partial matching -----
l <- list(aasfrr = 1:5)
l$a                       # Find aasfrr byr partial matching
l[["a"]]                  # Find nothing cuz a does not exist in l
l[["a", exact = FALSE]]   # Find aasfrr byr partial matching


# ----- Subetting - removing NA values -----
v <- c(1,2,NA,4,NA,5)
bad <- is.na(v)       # Create logical vector for NA values
v[!bad]               # Get only not NA values
x <- c(1,2,NA,4,NA,5)
y <- c("1","2",NA,"4",NA,"5")
good <- complete.cases(x,y)  # Check wether the corresponding elements are not NA
x[good]                      # Get not NA elements from x that matches y
y[good]                      # Get not NA elements from y that matches x
airquality[1:6,]
good <- complete.cases(airquality)       # Not NA elements in airquality
good <- complete.cases(airquality[1:6,]) # Not NA elements in airquality[1:6,]
airquality[good,][1:6,]                  # Get not NA elements from airquality


# ----- Vectorized Operations -----
x <- 1:4
y <- 6:9
x + y
x > 2
x >= 2
y == 8
x * y
x / y
m1 <- matrix(1:4,2,2)
m2 <- matrix(rep(10,4),2,2)
m1 * m2   # Multiplication per element
m1 / m2   # Division per element
m1 %*% m2 # True matrix multiplication