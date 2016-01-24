library(shiny)
library(tm)
library(stylo)
library(data.table)
library(RWeka)
library(stringr)
library(dplyr)

shinyServer(
  function(input,output) {
    
    # Display text user provided
    txtReturn <- eventReactive(input$button1, {
      paste(input$text1)
    })
    output$text11 <- renderText({ txtReturn() })
    
    # Display 'clean' version of user text
    adjustedTxt <- eventReactive(input$button1, {
      tail(txt.to.words(cleanUserInput(input$text1)), 3)
    })
    output$text22 <- renderText({ adjustedTxt() })
    
    # Get list of predicted words
    nextWord <- eventReactive(input$button1, {
      getPredWord(input$text1, input$words1)
    })
    output$table1 <- renderTable({ nextWord() })
    
    
  }
  
)