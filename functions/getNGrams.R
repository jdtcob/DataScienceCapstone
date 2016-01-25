getNGrams <- function(dw, n) {
  rawNGram <- NGramTokenizer(dw, Weka_control(min = n, max = n))
  removeEntry <- grep("\\bc \\b",rawNGram)
  
  if (length(removeEntry) > 0) {
    rawNGram <- rawNGram[-c(removeEntry)]
  }
  return(rawNGram)
}