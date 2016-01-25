cleanUserInput <- function(x, flag = TRUE) {
  
  # Convert all characters to lower case
  x <- tolower(x)
  
  # Remove twitter hashtags
  x <- gsub("#\\S+", "", x)
  
  # Remove "rt"
  x <- gsub("\\brt\\b", "", x)
  
  # Replace contractions
  x <- replaceContr(x)
  
  # Remove numbers or foreign characters.
  x <- gsub("[^a-z ]", "", x)
  
  # Remove profanity and 'stopwords'
  load("profanity.RData")
  x <- removeWords(x, profanity)
  
  # Remove 'stopwords' based on user input
  if (flag) {
    x <- removeWords(x, stopwords("english"))
  }
  
  # Replace single letters with full words
  x <- replaceSingleWords(x)
  
  # Remove extra blank space
  tmpData <- stripWhitespace(x)
}


replaceContr <- function(x) {
  # Replace common contractions
  
  # Exceptions
  x <- gsub("i'm", "i am", x)
  x <- gsub("can't", "cannot", x)
  x <- gsub("won't", "will not", x)
  x <- gsub("ain't", "am not", x)
  x <- gsub("what's", "what is", x)
  
  # Common occurences
  x <- gsub("'d", " would", x)
  x <- gsub("'re", " are", x)
  x <- gsub("n't", " not", x)
  x <- gsub("'ll", " will", x)
  x <- gsub("'ve", " have", x)
  return(x)
}


replaceSingleWords <- function (x) {
  # Transform "i will b there" to "i will be there", etc.
  x <- gsub("\\bb\\b", "be", x)
  x <- gsub("\\bc\\b", "see", x)
  x <- gsub("\\br\\b", "are", x)
  x <- gsub("\\bu\\b", "you", x)
  x <- gsub("\\by\\b", "why", x)
  x <- gsub("\\bo\\b", "oh", x)
}