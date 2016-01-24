library(shiny)


shinyUI(pageWithSidebar(
  headerPanel("Data Science Capstone Project"),
  sidebarPanel(
    h3("User Input"),
    br(),
    
    strong(""),
    textInput("text1", "Enter a phrase below:", value = "I am looking forward to seeing"),
    br(),

    selectInput("words1", "Maximum predicted words to return",
                choices = list("1" = 1, "2" = 2,
                               "3" = 3, "4" = 4,
                               "5" = 5, "6" = 6, 
                               "7" = 7, "8" = 8, 
                               "9" = 9, "10" = 10), selected = 5),
    br(),
    
    strong("Click the button below to return the predicted words."),
    actionButton("button1", "Analyze Text")
    
    
  ),
  mainPanel(
    tabsetPanel(
      
      tabPanel("Analysis",
               
               h4('The phrase that was provided:'),
               verbatimTextOutput("text11"),
               
               h4('The application interprets the text as:'),
               verbatimTextOutput("text22"),
               
               h4('The words predicted based on the phrase provided:'),
               tableOutput("table1")
               
      ),
      
      tabPanel("Documentation",
               h4("Project Requirements"),
               p("The goal of this exercise is to create a product to highlight the prediction 
                 algorithm that you have built and to provide an interface that can be accessed 
                 by others. For this project you must submit:"),
               p("1. A Shiny app that takes as input a phrase (multiple words) in a text box 
                 input and outputs a prediction of the next word."),
               p("2. A slide deck consisting of no more than 5 slides created with R Studio Presenter 
                  pitching your algorithm and app as if you were presenting to your boss or an investor."),
               p("A key point here is that the predictive model must be small enough to load onto the Shiny 
                  server. So pay attention to model size when creating and uploading your model."),
               br(),
               
               h4("Application Interface"),
               p("The User Input panel on the left contains three items. First is a text box to enter the 
                 phrase you'd like analyzed. Second is a drop down menu where you can select the maximum 
                 number of words to return. Third is a button, 'Analyze Text', that is the algorithm's call 
                 to action and initiates the analysis. Analysis will only be performed upon pressing this button."),
               p("The algorithm returns three things. First the 
                 original text that the user provided, second is the filtered text provided to the algorithm, third 
                 is a table. In the lefthand column of this table we have the predicted words, in the right hand 
                 column we have the log probability. The table is sorted from the most likely word in the first row 
                 to the least likely in the last row."),
               br(),
               
               h4("Application Functionality"),
               p("The first task is to filter the input, this is same text cleaning process we used on the SwiftKey
                 data. This includes removing numbers, punctuation, foreign characters, profanity, single letter words
                 (b, c, y, etc.), and contractions."),
               p("Next we search of matches based on the user input. For example if we have the input 'looking forward
                 seeing' a match is defined as 'looking forward seeing you'. Based on the maximum number of results to be
                 returned we may shorten the user input to find more matches. An example of shortening would be 'looking
                 forward seeing' to 'forward seeing'. If matches are found with shortened phrases a penalty is used to alter
                 the final log probability score."),
               p("Once we have the desired number of matches we use a probability model (an example of this model can be found at
                 X FILL X Slide 4) to give a score for each predicted word. Scores are then sorted in descending order
                 so the most likely word is at the top of the table returned."),
               br(),
               
               h4("Source Code"),
               p("For the sake of transparency all source code can be found on GitHub:"),
               p("fill")
               
             
               
               )
      ))
))