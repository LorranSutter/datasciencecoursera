pollutantmean <- function(directory, pollutant, id = 1:332){
  if(!dir.exists(directory)){
    stop(paste("Directory",directory,"does not exists!"))
  }
  
  if(pollutant != "sulfate" && pollutant != "nitrate"){
    stop(paste("Pollutant",pollutant,"does not exists!"))
  }
  
  if(any(id > 332) || any(id < 1)){
    stop("Id interval is out of range!")
  }
  
  soma <- c()
  for(k in id){
    a <- if(k < 10) "00" else if(k < 100) "0" else ""
    dataframe <- read.csv(paste(directory,"/",a,k,".csv",sep=""))
    soma <- c(soma,dataframe[complete.cases(dataframe[pollutant]),][[pollutant]])
  }
  
  sum(soma)/length(soma)
}

complete <- function(directory, id = 1:332){
  if(!dir.exists(directory)){
    stop(paste("Directory",directory,"does not exists!"))
  }
  
  if(any(id > 332) || any(id < 1)){
    stop("Id interval is out of range!")
  }
  
  cases <- c()
  for(k in id){
    a <- if(k < 10) "00" else if(k < 100) "0" else ""
    dataframe <- read.csv(paste(directory,"/",a,k,".csv",sep=""))
    cases <- c(cases,sum(complete.cases(dataframe)))
  }
  
  data.frame(id = id, nobs = cases)
}

corr <- function(directory, threshold = 0){
  if(!dir.exists(directory)){
    stop(paste("Directory",directory,"does not exists!"))
  }
  
  correlations <- c()
  for(f in list.files(directory)){
    dataframe <- read.csv(paste(directory,"/",f,sep=""))
    dataframe <- dataframe[complete.cases(dataframe),]
    
    if(nrow(dataframe) > threshold)
      correlations <- c(correlations, cor(dataframe$sulfate, dataframe$nitrate))
  }
  
  if(length(correlations) > 0)
    correlations
  else
    numeric()
  
}