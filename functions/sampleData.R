sampleData <- function(tmpData, percent = 0.05) {
  
  numLines <- length(tmpData)
  
  tmpData <- sample(tmpData, size = numLines * percent, replace = FALSE)
  
  return(tmpData)
}