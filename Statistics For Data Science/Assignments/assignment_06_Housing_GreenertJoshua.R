# Assignment: ASSIGNMENT 7
# Name: Greenert, Joshua
# Date: 7/27/2022
library(readxl)
library(plyr)
library(ggplot2)
library(QuantPsyc)
library(car)

# Set the working directory and upload the file.
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science")
housingDF <- read_excel("data/week-6-housing.xlsx")

# 1. Data transformations: Explain modifications to the data.
'''
Removed outliers where the amount of bedrooms were significantly larger than the rest of the dataset.
Removed outliers where the square footage of the home was significantly larger than the rest.
'''

# 2. Create two variables; one that will contain the variables Sale Price and Square Foot of Lot 
#  (same variables used from previous assignment on simple regression) and one that will contain Sale Price and several 
#  additional predictors of your choice. Explain the basis for your additional predictor selections.
salePrice_lm <-  lm(`Sale Price` ~ sq_ft_lot, data = housingDF)
salePriceWithOthers_lm <-  lm(`Sale Price` ~ sq_ft_lot + building_grade + bedrooms + year_built, data=housingDF)
'''
These variables were chosen since they are numeric and can isolate patterns from the data.
'''

# 3. Execute a summary() function on two variables defined in the previous step to compare the model results. 
#  What are the R2 and Adjusted R2 statistics? Explain what these results tell you about the overall model. 
#  Did the inclusion of the additional predictors help explain any large variations found in Sale Price?
summary(salePrice_lm)
summary(salePriceWithOthers_lm)
'''
salePrice_lm: Multiple R-squared:  0.01147,	Adjusted R-squared:  0.01139
salePriceWithOthers_lm: Multiple R-squared:  0.1832, Adjusted R-squared:  0.1829 

The first model R-squared value means that, with the values selected, we can explain 1% of the variance for the data.  Likewise, 
the second model R-squared value means that we can explain 18% of the variance.  The inclusion of the extra variables provide 
a larger amount of insight into the variance from the data by providing a difference of 17%.
'''

# 4. Considering the parameters of the multiple regression model you have created. What are the standardized betas 
#  for each parameter and what do the values indicate?
print('salePrice_lm Beta')
lm.beta(salePrice_lm)
print('salePriceWithOthers_lm Beta')
lm.beta(salePriceWithOthers_lm)
'''
salePrice_lm Beta:
sq_ft_lot 
0.1070844 

salePriceWithOthers_lm Betas:
sq_ft_lot building_grade       bedrooms     year_built 
0.0839968      0.2789265      0.1227669      0.1559643 

The standardized beta values represent the strength of the effect that they provide.
From the beta values, it would appear that building_grade, bedrooms, and year_built provide more of an effect than sq_ft_lot.
'''

# 5. Calculate the confidence intervals for the parameters in your model and explain what the results indicate.
confint(salePrice_lm, level = 0.95)
'''
                   2.5 %       97.5 %
(Intercept) 6.327120e+05 6.477299e+05
sq_ft_lot   7.417016e-01 1.025461e+00

The values of the confidence intervals show a narrow gap between them; therefore, the confidence intervals appear decent.
'''
confint(salePriceWithOthers_lm, level = 0.95)
'''
                       2.5 %        97.5 %
(Intercept)    -8.398742e+06 -6.829898e+06
sq_ft_lot       5.595682e-01  8.265912e-01
building_grade  9.572714e+04  1.092259e+05
bedrooms        4.869468e+04  6.408702e+04
year_built      3.219730e+03  4.024057e+03

Unlike the previous model, this model has a larger gap between the upper and lower bounds.  This provides less of a chance
that the values would be accurate when used with values outside of the current model.
'''

# 6. Assess the improvement of the new model compared to your original model (simple regression model) by testing 
#  whether this change is significant by performing an analysis of variance.
anova(salePrice_lm, salePriceWithOthers_lm)
'''
  Res.Df        RSS Df Sum of Sq   F    Pr(>F)    
1  12846 2.0258e+15                               
2  12843 1.6739e+15  3 3.519e+14 900 < 2.2e-16 ***

Because the F value references is much greater than the first model, we can assume that the second model worsened our fit.
'''

# 7. Perform casewise diagnostics to identify outliers and/or influential cases, storing each function's output in a 
#  dataframe assigned to a unique variable name.
firstModel$residuals =  resid(salePrice_lm)
secondModel$residuals = resid(salePriceWithOthers_lm)

firstModel$standardized.residuals<- rstandard(salePrice_lm)
firstModel$studentized.residuals<- rstudent(salePrice_lm)
firstModel$dfbeta<- dfbeta(salePrice_lm)
firstModel$dffit<- dffits(salePrice_lm)

secondModel$standardized.residuals<- rstandard(salePriceWithOthers_lm)
secondModel$studentized.residuals<- rstudent(salePriceWithOthers_lm)
secondModel$dfbeta<- dfbeta(salePriceWithOthers_lm)
secondModel$dffit<- dffits(salePriceWithOthers_lm)

# 8. Calculate the standardized residuals using the appropriate command, specifying those that are +-2, storing the 
#  results of large residuals in a variable you create.
firstModel$large.residuals <- firstModel$standardized.residuals > 2 | firstModel$standardized.residuals < -2
secondModel$large.residuals <- secondModel$standardized.residuals > 2 | secondModel$standardized.residuals < -2

# 9. Use the appropriate function to show the sum of large residuals.
sum(firstModel$large.residuals)
sum(secondModel$large.residuals)

# 10. Which specific variables have large residuals (only cases that evaluate as TRUE)?
firstModel[firstModel$large.residuals]
secondModel[secondModel$large.residuals ]
'''
This question is a bit unclear but the first model (firstModel$large.residuals) has the most large residuals.
'''

# 11. Investigate further by calculating the leverage, cooks distance, and covariance rations. Comment on all cases that are problematics.
firstModel$leverage<- hatvalues(salePrice_lm)
firstModel$covariance.ratios<- covratio(salePrice_lm)
firstModel$cooks.distance<- cooks.distance(salePrice_lm)

secondModel$cooks.distance<- cooks.distance(salePriceWithOthers_lm)
secondModel$leverage<- hatvalues(salePriceWithOthers_lm)
secondModel$covariance.ratios<- covratio(salePriceWithOthers_lm)

# 12. Perform the necessary calculations to assess the assumption of independence and state if the condition is met or not.
durbinWatsonTest(salePrice_lm)
durbinWatsonTest(salePriceWithOthers_lm)
'''
From the test above, we can determine from the p-value that the test is statistically significant.  Likewise, the D-W statistic
proves that the assumption has been met.  The same holds true for both models.
'''

# 13. Perform the necessary calculations to assess the assumption of no multicollinearity and state if the condition is met or not.
secondModelVif = mean(vif(salePriceWithOthers_lm))
'''
Vif only works on models with more than one term.  The secondModelVif returns: 1.207167
Since the vif is below 10, our model is find and the condition is met.
'''

# 14. Visually check the assumptions related to the residuals using the plot() and hist() functions. Summarize what each graph is 
#  informing you of and if any anomalies are present.
histogram<-ggplot(secondModel, aes(studentized.residuals)) + geom_histogram(aes(y=..density..), color= "black", fill = "white") + labs(x = "Studentized Residual", y="Density")
histogram + stat_function(fun = dnorm, args= list(mean = mean(secondModel$studentized.residuals, na.rm = TRUE), sd = sd(secondModel$studentized.residuals, na.rm=TRUE)), color = "red", size = 1)

# 15. Overall, is this regression model unbiased? If an unbiased regression model, what does this tell us about the sample vs. 
#  the entire population model?
'''
Overall, the regression model is unbiased which concludes that the model is a good predictor for future use-cases.  With the entire
population, we can say that this model will have an accurate estimation to produce the results we are looking for.
'''


