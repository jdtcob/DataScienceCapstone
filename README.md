This repository contains all files necessary for the Data Science Capstone final project.


Project requirements:
The goal of this exercise is to create a product to highlight the prediction algorithm that you have built and to provide an interface that can be accessed by others. For this project you must submit:

1. A Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word.
2. A slide deck consisting of no more than 5 slides created with R Studio Presenter pitching your algorithm and app as if you were presenting to your boss or an investor.

A key point here is that the predictive model must be small enough to load onto the Shiny server. So pay attention to model size when creating and uploading your model.


The SwiftKey Data:
The data is from a corpus called HC Corpora (www.corpora.heliohost.org). See the readme file at http://www.corpora.heliohost.org/aboutcorpus.html for details on the corpora available. The files have been language filtered but may still contain some foreign text. In this capstone we will be applying data science in the area of natural language processing. The data used for this project can be accessed [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)


Repository Files:
- createFilteredTables.R: this file takes the raw data and creates the file 'NGramSortedFinal.txt'
	+ this file also uses the files in the 'functions' folder
- profanity.RData: a list of words to remove
- NGramSortedFinal.txt: contains one large table (four concatenated tables) and the associated counts
- divideNGram.RData: contains positions used to divide the table (in NGramSortedFinal.txt) into look up tables for 1,2,3,4 gram
	+ NGramSortedFinal.txt and divideNGram.RData are used to load and divide the tables used for searching for a match. This load/division step is performed for the sake of speed of the algorithm. In lieu of loading four files we load one file (four tables concatenated) and then divide the single data frame into four separate data frames according to number of words.
- getPredWord.R: this is the main function called by server.R for the application interface
	+ This file searches for matches based on the user input, for example, "looking forward seeing _____" 
	+ If no matches are found we shorten the input and search again, "foward seeing ____"
	+ If the input is shortened we also assign a penalty, this is also known as the "Stupid Backoff"
- global.R: loads the lookup tables to search for matches, loads additional libraries and functions
- server.R: code necessary to access the user input, call functions necessary to predict the next word, and return results to the user interface 
- ui.R: code necessary for the application interface
	+ Input: Text box that accepts a phrase, a drop down menu which sets the maximum number of words returned, and an "Analyze Text" button which initiates the algorithm 
	+ Output: The original phrase, a filtered phrase that is provided to the algorithm, and a table that returns the predicted words

