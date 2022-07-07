# Assignment: ASSIGNMENT 5
# Name: Greenert, Joshua
# Date: 7/5/2022
'''
Using either the same dataset(s) you used in the previous weeks’ exercise or a brand-new dataset
of your choosing, perform the following transformations
'''
library(ggplot2)
library(plyr)
library(magrittr)
library(dplyr)

# 1.Using the dplyr package, use the 6 different operations to analyze/transform the data - GroupBy, Summarize, Mutate, 
#   Filter, Select, and Arrange – Remember this isn’t just modifying data, you are learning about your data also – so 
#   play around and start to understand your dataset in more detail
testScoresDF <- read.csv("data/scores.csv")

# Groupby:  section and show mean of scores
testScoresDF %>% group_by(Section) %>% summarize(AvgScore=mean(Score))

# Summarize: the counts of each section grouped
testScoresDF %>% group_by(Section) %>% summarize(AvgScore=mean(Count))

# Mutate: add a new row for the count divided by score
testScoresDF %>% select(Section, Score, Count) %>% mutate(Ratio=Count/Score) 

# Filter: show only the scores greater than or equal to 300.
testScoresDF %>% filter(Score >= 300)

# Select: select only the section and scores.
testScoresDF %>% select(Section, Score)

# Arrange: sort by score descending.
testScoresDF %>% select(Section, Score) %>% arrange(desc(Score))

# 2.Using the purrr package – perform 2 functions on your dataset.  You could use zip_n, keep, discard, compact, etc.
#a.Using map to get sum of all scores.
scores <- testScoresDF['Score']
scores %>% map(function(x) sum(x, na.rm=TRUE))

#b.Use map_int to count the number of rows returned.
scores %>% map_int(NROW)

# 3.Use the cbind and rbind function on your dataset
#cbind
scores <- testScoresDF['Score']
counts <- testScoresDF['Count']
sections <- testScoresDF['Section']
newTestScores <- cbind(scores, counts, sections)

#rbind
rbindExample <- rbind(newTestScores, testScoresDF)
rbindExample

# 4.Split a string, then concatenate the results back together
splitStrExample <- "This String"
splitStr <- strsplit(splitStrExample, " ")
finalStr <- paste(splitStr, collapse=" ")
finalStr