## Pair of functions that cache a matrix and its inverse

## Create a special type that store a matrix and its inverse matrix
## Allow get and set both the matrix and its inverse by lexical scoping

makeCacheMatrix <- function(x = matrix()) {
  invM <- NULL
  
  set <- function(y){
    x <<- y
    invM <<- NULL
  }
  get <- function() x
  
  setInverseMatrix <- function(inverseMatrix) invM <<- inverseMatrix
  getInverseMatrix <- function() invM
  
  list(set = set, get = get,
       setInverseMatrix = setInverseMatrix,
       getInverseMatrix = getInverseMatrix)
}


## Return a matrix that is the inverse of 'x'
## Store inverse matrix in x if it is not in cache
## Only compute the inverse if it is not calculated or if the matrix changes

cacheSolve <- function(x, ...) {
  invM <- x$getInverseMatrix()
  if(!is.null(invM)){
    message("getting cached data")
    return(invM)
  }
  
  data <- x$get()
  invM <- solve(data, ...)
  x$setInverseMatrix(invM)
  
  invM
}
