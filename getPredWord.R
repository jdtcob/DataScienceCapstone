getPredWord <- function(phraseIn, wordsOut = 5, flag = TRUE) {
  
  # lastWord <- NA
  userWords <- txt.to.words(cleanUserInput(phraseIn, flag))
  numWords <- length(userWords)
  
  # If user input is blank space or is filtered out, return common unigrams
  if (numWords==0){
    lastWord <- as.data.frame(as.character(data1gram$word[1:wordsOut]))
    return(lastWord)
  }
  
  # Cuts user input down to the last 3 words
  if (numWords > 3) {
    numWords <- 3
    userWords <- tail(userWords, numWords)
  }

  # This for loop searches for matches, removes common results if necessary
  matchLen <- NULL
  matchList <- NULL
  for (i in numWords:1) {
    tempResults <- NULL
    tempResults <- getNextWord(tail(userWords, i))
    
    if (is.na(tempResults[1])) {
      matchLen <- c(matchLen, 0)
    } else {
      
      logicRemove <- tempResults %in% matchList
      matchList <- c(matchList, tempResults[!logicRemove])

      matchLen <- c(matchLen, length(tempResults[!logicRemove]))
      rm(logicRemove, tempResults)
    }
    if (sum(matchLen) > wordsOut) {break}
    
  }
  
  # If user phrase is non english or fake words return unigram list
  if (sum(matchLen)==0) {
    lastWord <- as.data.frame(as.character(data1gram$word[1:wordsOut]))
    return(lastWord)
  }
  
  # These 3 lines remove zeros from the term matchLen
  # revInd is used to trim the user input for the getMatchProb function
  revInd <- numWords:1
  revInd <- revInd[!(matchLen %in% 0)]
  matchLen <- matchLen[!(matchLen %in% 0)]
  
  # Calculate stupid backoff adjustment
  stepDown <- NULL
  for (i in 1:length(matchLen) ) {
    
    if(matchLen[i]!=0){
      
      if (i==1){
        stepDown <- c(stepDown, rep(log(1), matchLen[i]) )
      } else {
        stepDown <- c(stepDown, rep(log(0.4^(i-1)), matchLen[i]))
      }
      
    } else {
      stepDown <- c(stepDown, NULL)
    }
    
  }
  
  # Add comments
  if (length(matchList)>20) {
    matchList <- matchList[1:20]
    stepDown <- stepDown[1:20]
  }
  
  # Calculate log probability
  prob <- NULL
  for (i in 1:length(unique(stepDown))) {
    temp <- NULL
    temp <- stepDown %in% unique(stepDown)[i]
    
    prob <- c(prob, getMatchProb( matchList[temp], tail(userWords, revInd[i]) ))
  }
  
  # Create data frame of results, sort results
  bestGuess <- data.frame( word=matchList, logProb=as.numeric(prob+stepDown), stringsAsFactors = FALSE )
  bestGuess <- arrange(bestGuess, desc(logProb))
  return(bestGuess[1:wordsOut,])
  
}
