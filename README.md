# Data Science Capstone Final Project: A Text Prediction Algorithm built with the SwiftKey Dataset
This README file describes the algorithm and all files necessary to satisfy the shinyApps requirement for the Data Science Capstone final project.

### From the Coursera Course website
Project Requirements:
The goal of this exercise is to create a product to highlight the prediction algorithm that you have built and to provide an interface that can be accessed by others. For this project you must submit:

1. A Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word.
2. A slide deck consisting of no more than 5 slides created with R Studio Presenter pitching your algorithm and app as if you were presenting to your boss or an investor.

**This repository contains all the files necessary to satisfy the shinyApps requirement**


### SwiftKey Data
The data is from a corpus called HC Corpora (www.corpora.heliohost.org). See the readme file at http://www.corpora.heliohost.org/aboutcorpus.html for details on the corpora available. The files have been language filtered but may still contain some foreign text. In this capstone we will be applying data science in the area of natural language processing. The data used for this project can be accessed [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)


### Text Prediction Flowchart
![Flow](figures/flowChartCapstone.png)

- Step 1: We begin with user input and filter it to remove profanity, punctuation, contractions, numbers, foreign characters, common words, and any extra white space.
	+ If the user enters "I am looking forward to seeing the" the algorithm will analyze "looking forward seeing" 
- Step 2: Search for a match, "looking forward seeing _____"
	+ If sufficient number of matches are found, skip to Step 4
- Step 3: If more matches are needed we shorten user input, calculate penalty, and search again
	+ "looking forward seeing" >>> "forward seeing"
- Step 4: Calculate probability score, add penalty if necessary
	+ log probability is employed to increase algorithm speed since addition is faster than multiplication


### Calculating Probability Score
The image below shows a conventional method for calculating the probability of a sentence. In our case we wish to predict the next word given a certain phrase.

![prob1](figures/probBase.png)

If we employ a Markov assumption, seen below, we can reduce the computational complexity of the equation above which will also increase the speed of our algorithm.

![prob2](figures/probMarkov.png)

The equation below shows the model used to calculate a probability score for each predicted word. Multiplication is replaced with addition when dealing with log probability. In the event the "Stupid Backoff" was employed we also must add our penalty to the probability score. Every time the input is shortened we must multiply the probability score by 0.4. In our case we add log(0.4) to our probability scores.

![prob3](figures/probCapstone.png)


### Rationale for the Algorithm
From the final project requirements "A key point here is that the predictive model must be small enough to load onto the Shiny server. So pay attention to model size when creating and uploading your model." From the grading rubric "When you type a phrase in the input box do you get a prediction of a single word after pressing submit and/or a suitable delay for the model to compute the answer?"


Based on these requirements we chose a model that would function quickly and not get hung upon a user input that it had never encountered. If the user provides random text "awpu1iub325 oi1398th351bvnnd qwliwiu2451" the algorithm will simply return the most common unigrams. In this manner we avoid using extra memory while quickly returning a result.


### Repository Files
- createFilteredTables.R: this file takes the raw data and creates the file 'NGramSortedFinal.txt'
	+ this file uses the files in the 'functions' folder
- profanity.RData: a list of words to remove
- NGramSortedFinal.txt: contains four concatenated tables and the associated NGram counts
- divideNGram.RData: contains positions used to divide the table (from NGramSortedFinal.txt) into look up tables
	+ NGramSortedFinal.txt and divideNGram.RData are used to load and divide the tables used for searching for a match. In lieu of loading four files we load one file and then divide the single data frame into four separate data frames according to number of words.
- getPredWord.R: this is the main function called by server.R for the application interface
	+ This file searches for matches based on the user input, implements "Stupid Backoff" if necessary, and calculate a penalty for the probability score
- global.R: loads the lookup tables to search for matches, loads additional libraries and functions
- server.R: code necessary to access user input, call functions necessary to predict the next word, and return results to the user interface 
- ui.R: code necessary for the application interface
	+ Input: Text box that accepts a phrase, a drop down menu which sets the maximum number of words returned, and an "Analyze Text" button which initiates the algorithm 
	+ Output: The original phrase, a filtered phrase that is provided to the algorithm, and a table that returns the predicted words

### Shiny App
Click [https://jdtcob.shinyapps.io/project/](https://jdtcob.shinyapps.io/project/) to view the working application.