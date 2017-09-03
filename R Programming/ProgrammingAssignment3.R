setwd("C:/Users/Lorran Sutter/datasciencecoursera/R Programming")

# ----- 1 Plot the 30-day mortality rates for heart attack -----

outcome <- read.csv("ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")

head(outcome)
ncol(outcome)
nrow(outcome)
names(outcome)

outcome[, 23] <- as.numeric(outcome[, 23])
hist(outcome[, 23])
hist(outcome[, 11])



# ----- 2 Finding the best hospital in a state -----

# 2 - Hospital.Name
# 7 - State
# 11 - "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
# 17 - "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
# 23 - "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"

outcomeFile <- read.csv("ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
outcomeFile[, 11] <- as.numeric(outcomeFile[, 11])
outcomeFile[, 17] <- as.numeric(outcomeFile[, 17])
outcomeFile[, 23] <- as.numeric(outcomeFile[, 23])

best <- function(state, outcome) {
  ## Read outcome data
  outcomeFile <- read.csv("ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  outcomeFile[, 11] <- as.numeric(outcomeFile[, 11])
  outcomeFile[, 17] <- as.numeric(outcomeFile[, 17])
  outcomeFile[, 23] <- as.numeric(outcomeFile[, 23])
  
  ## Check that state and outcome are valid
  if(!(state %in% outcomeFile$State)){
    stop("Error in best(\"", state, "\", \"", outcome, "\") : invalid state")
  }
  
  if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia"){
    stop("Error in best(\"", state, "\", \"", outcome, "\") : invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  outcome <- if(outcome == "heart attack")
    11
  else if(outcome == "heart failure")
    17
  else
    23
  
  outcomeFileFiltered <- outcomeFile[,c(2,7,outcome)]
  outcomeFileFiltered <- outcomeFileFiltered[outcomeFileFiltered$State == state,]
  outcomeFileFiltered <- outcomeFileFiltered[complete.cases(outcomeFileFiltered),]
  
  outcomeFileFiltered$Hospital.Name[outcomeFileFiltered[3] == min(outcomeFileFiltered[3])]
}

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomeFile <- read.csv("ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  outcomeFile[, 11] <- as.numeric(outcomeFile[, 11])
  outcomeFile[, 17] <- as.numeric(outcomeFile[, 17])
  outcomeFile[, 23] <- as.numeric(outcomeFile[, 23])
  
  ## Check that state and outcome are valid
  if(!(state %in% outcomeFile$State)){
    stop("Error in best(\"", state, "\", \"", outcome, "\") : invalid state")
  }
  
  if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia"){
    stop("Error in best(\"", state, "\", \"", outcome, "\") : invalid outcome")
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  outcome <- if(outcome == "heart attack")
    11
  else if(outcome == "heart failure")
    17
  else
    23
  
  outcomeFileFiltered <- outcomeFile[,c(2,7,outcome)]
  outcomeFileFiltered <- outcomeFileFiltered[outcomeFileFiltered$State == state,]
  outcomeFileFiltered <- outcomeFileFiltered[complete.cases(outcomeFileFiltered),]
  
  outcomeFileFiltered <- if(num == "best"){
    outcomeFileFiltered[outcomeFileFiltered[3] == min(outcomeFileFiltered[3]),]
  }else if(num == "worst"){
    outcomeFileFiltered[outcomeFileFiltered[3] == max(outcomeFileFiltered[3]),]
  }else{
    if(num > nrow(outcomeFileFiltered)){
      return(NA)
    }
    orderedRate <- order(outcomeFileFiltered[3],outcomeFileFiltered[1])
    #outcomeFileFiltered[orderedRate, ][num,]
    outcomeFileFiltered[orderedRate, ]
  }
  
  names(outcomeFileFiltered) <- c("Hospital","State","Outcome")
  #head(outcomeFileFiltered,num)
  if(is.numeric(num))
    outcomeFileFiltered[num,]
  else
    outcomeFileFiltered
}

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomeFile <- read.csv("ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  outcomeFile[, 11] <- as.numeric(outcomeFile[, 11])
  outcomeFile[, 17] <- as.numeric(outcomeFile[, 17])
  outcomeFile[, 23] <- as.numeric(outcomeFile[, 23])
  
  ## Check that state and outcome are valid
  if(outcome != "heart attack" && outcome != "heart failure" && outcome != "pneumonia"){
    stop("Error in best(\"", state, "\", \"", outcome, "\") : invalid outcome")
  }
  
  ## For each state, find the hospital of the given rank
  outcome <- if(outcome == "heart attack")
    11
  else if(outcome == "heart failure")
    17
  else
    23
  
  outcomeFile <- outcomeFile[,c(2,7,outcome)]
  names(outcomeFile) <- c("hospital","state","outcome")
  outcomeFile <- split(outcomeFile, outcomeFile$state)
  result <- data.frame(hospital = "", state = "", outcome = "outcome")
  
  for(outcomeFileState in outcomeFile){
    
    outcomeFileState <- outcomeFileState[complete.cases(outcomeFileState),]
    
    outcomeFileState <- if(num == "best"){
      outcomeFileState[outcomeFileState[3] == min(outcomeFileState[3]),]
    }else if(num == "worst"){
      outcomeFileState[outcomeFileState[3] == max(outcomeFileState[3]),]
    }else{
      if(num > nrow(outcomeFileState)){
        data.frame(hospital = NA, state = "state", outcome = "outcome")
      }else{
        orderedRate <- order(outcomeFileFiltered[3],outcomeFileFiltered[1])
        outcomeFileFiltered[orderedRate, ]
      }
    }
    
    #result <- rbind(result, outcomeFileState[,c(1,2)])
    result <- rbind(result, outcomeFileState)
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  result
}