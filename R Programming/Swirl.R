# ----- Workspace and Files -----
getwd()                               # Get current directory
ls()                                  # List variables inf workspace
list.files()                          # List files in current directory (same as dir())
args(list.files)                      # Check arguments of the function parameter
dir.create("testdir")                 # Create directory
file.create("mytest.R")               # Create file
file.exists("mytest.R")               # Check if the file exists
file.info("mytest.R")                 # Get file information
file.rename("mytest.R","mytest2.R")   # Rename file
file.copy("mytest2.R","mytest3.R")    # Create a file copy
file.path("mytest3.R")                # Create a path to the file
file.path('folder1','folder2')        # Create a path
dir.create(file.path("testdir2","testdir3"),recursive = TRUE)  # Create directory with path parameter


# ----- Sequences of numbers -----
?':'
seq(1,20)
seq(0,10,by=0.5)                  # Sequence spaced by by
seq(5,10,length = 30)             # Sequence with length elements
my_seq <- seq(5,10,length = 30)
seq(along.with = my_seq)          # Create a sequence with my_seq length
seq_along(my_seq)                 # Create a sequence with my_seq length
rep(0,times=40)                   # Repeat param times times
rep(c(0,1,2),times=10)            # Repeat vector times times
rep(c(0,1,2),each=10)             # Repeat vector like 0 0 0 ... 1 1 1 ... 2 2 2 ...


# ----- Vectors -----
my_char <- c("My","name","is")
paste(my_char, collapse = " ")    # Concatenate vectors after converting to char, collapse separete output
paste("Hello","world!",sep=" ")   # sep is a char to separate terms of each vector, pair to pair
paste(1:3,c("X","Y","Z"),sep="")  # First convert to 1:3 to char
paste(LETTERS, 1:4, sep="-")      # LETTERS predefined variable char vector of all 26 letters


# ----- Missing Values -----
y <- rnorm(1000)               # Generate 1000 normal random numbers
z <- rep(NA,1000)              
my_data <- sample(c(y,z),100)  # Generate a sample permutation of y and z
my_na <- is.na(my_data)        # Check NA values
sum(my_na)                     # Count NA values
0/0                            # NaN
Inf - Inf                      # NaN


# ----- Subsetting Vectors -----
x[is.na(x)]                               # Get all NA elements
y <- x[!is.na(x)]                         # Get not NA x elements
y[y>0]                                    # Get grater than 0 y elements
x[!is.na(x) & x>0]                        # Get not NA and grater than 0 x elements
x[c(3,5,7)]                               # Get 3rd, 5th and 7th x element
x[0]                                      # Get apparently the vector type
x[3000]                                   # Get trash
x[c(-2,-10)]                              # Get elements from x minus 2nd and 10th
x[-c(2,10)]                               # Same as above
vect <- c(foo = 11, bar = 2, norf = NA)   # Create a named vector
names(vect)                               # Show vect names
vect2 <- c(11,2,NA)                       # Create a vector
names(vect2) <- c("foo","bar","norf")     # Assing names to vect2
identical(vect,vect2)                     # Check if vect ans vect2 are identical
vect["bar"]                               # Get vect element named bar
vect[c("foo","bar")]                      # Get more than one named element


# ----- Matrices and Data Frames -----
my_vector <- 1:20
dim(my_vector)                                               # Return NULL cuz my_vector has no dim attr
length(my_vector)                                            # Get number of elements of my_vector
dim(my_vector) <- c(4,5)                                     # Assing 4,5 to my_vector dimension
attributes(my_vector)                                        # Get my_vector attributes
my_matrix <- my_vector
my_matrix2 <- matrix(1:20,4,5)                               # Create a matrix 4,5 dim and 1:20 elements
patients <- c("Bill","Gina","Kelly","Sean")
cbind(patients,my_matrix)                                    # Create a matrix combining columns
my_data <- data.frame(patients,my_matrix)                    # Create data.frame joing vector and matrix
cnames <- c("patient","age","weight","bp","rating","test")
colnames(my_data) <- cnames                                  # Assign cnames to column names of my_data


# ----- Simulation -----
sample(1:6,4,replace = TRUE) 
sample(1:20,10)
# Sample of c(0,1), 100 times, allow repeat vars, probabilitu of 30% 0 and 70% 1
flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3,0.7))
sum(flips)                                   # Total number of heads
rbinom(1, size = 100, prob = 0.7)            # Bonomial distribution 1 time, 1:100, prob 70% near 100
flips2 <- rbinom(100, size = 1, prob = 0.7)  # Bonomial distribution 100 times, c(0,1), prob 70% 1
sum(flips2)                                  # Total number of heads
rnorm(10)                                    # 10 random numbers
rnorm(10, mean = 100, sd = 25)               # 10 random numbers, mean 100, standard deviation 25
rpois(5,10)                                  # Poisson distributio, 5 times, lambda 10
my_pois <- replicate(100, rpois(5,10))       # Replicate action 100 times, generate a data.frame
cm <- colMeans(my_pois)                      # Mean of the columns
hist(cm)                                     # Print histogram