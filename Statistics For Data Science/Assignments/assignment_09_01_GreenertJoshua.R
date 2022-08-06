# Assignment: ASSIGNMENT 9 Exercise 1
# Name: Greenert, Joshua
# Date: 8/4/2022
library(foreign)
library(mlogit)
library(car)

# Set the working directory.
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science")
surgeryARF <- read.arff("data/ThoraricSurgery.arff")

# Fit a binary logistic regression model to the data set that predicts whether or not the patient survived for one year 
#  (the Risk1Y variable) after the surgery. Use the glm() function to perform the logistic regression. See Generalized Linear 
#  Models for an example. Include a summary using the summary() function in your results.
surgeryModel <- glm(Risk1Yr ~ DGN + PRE4 + PRE5 + PRE6 + PRE7 + PRE8 + PRE9 + PRE10 + PRE11 + PRE14 + PRE17 + PRE19 + PRE25 + PRE30 + PRE32 + AGE, data = surgeryARF, family = binomial())
summary(surgeryModel)

# According to the summary, which variables had the greatest effect on the survival rate?
'''
According to the resulting values from the summary the most impactful variables were PRE19 with a -14.66% correlation and 
DGNDGN8 with a positive correlation of 18.03%.  
'''

# To compute the accuracy of your model, use the dataset to predict the outcome variable. The percent of correct predictions 
#  is the accuracy of your model. What is the accuracy of your model?
predictions <- predict(surgeryModel, surgeryARF)

# Risk1Yr is set in T and F values.  Set predictions to match format.
surgeryARF$predictions <- ifelse(predictions >= 0.5, "T", "F")

accuracyCheck <- mean(surgeryARF$predictions == surgeryARF$Risk1Yr)
accuracyCheck
'''
The accuracy check returns a value of 85.10% which indicates that the model is fairly accurate for making these predictions.
'''
