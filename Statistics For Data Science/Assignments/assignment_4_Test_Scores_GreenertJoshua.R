# Assignment: ASSIGNMENT 4 Test Scores
# Name: Greenert, Joshua
# Date: 7/1/2022

# 1.What are the observational units in this study?
In this instance, the observational units are the test scores (the entity) in which the students took.

# 2.Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
The variables in this case are the methods used for teaching (with sports or not), the test scores, and the counts
of each test score.  The teaching method is notably categorical since a concept cannot be quantitative.  However,
the test scores and the counts of each score are quantitative and can be calculated.

# 3.Create one variable to hold a subset of your dataset that contains only the Regular Section and one variable 
#   for the Sports Section.
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science")
testScoresDF <- read.csv("data/scores.csv")
sportsDF <- subset(testScoresDF, Section == "Sports")
regularDF <- subset(testScoresDF, Section == "Regular")

# 4.Use the Plot function to plot each Section's scores and the number of students achieving that score. Use additional Plot Arguments to 
#   label the graph and give each axis an appropriate label. Once you have produced your Plots answer the following questions:
sportsPlot <- plot(sportsDF$Score, sportsDF$Count, main="Sports Scatterplot",
                   xlab="Scores", ylab="Count of Students")

regularPlot <- plot(regularDF$Score, regularDF$Count, main="Regular Scatterplot",
                   xlab="Scores", ylab="Count of Students")

#   1.Comparing and contrasting the point distributions between the two section, looking at both tendency and consistency: 
#     Can you say that one section tended to score more points than the other? Justify and explain your answer.
sports(300) < 90 students
mean(sportsDF$Score, na.rm=TRUE)= 307.3684

regular(300) < 30 students
mean(regularDF$Score, na.rm=TRUE) = 327.6316

From the distributions, we can see that the students who were given the regular teaching sections had a larger chance of
scores greater than 300.  From this viewpoint, we can see that the students generally scored lower when provided the sports 
examples as opposed to those who were provided the regulars sections.  The ranges of the scores vary between the two Plots
and express that when provided the sports sections, the scores were significantly lower in general.  Moreover, the mean of
the regular group is greater than the mean of the sports group by approximately 20 points!

#   2.Did every student in one section score more points than every student in the other section? If not, explain what 
#     a statistical tendency means in this context.
Yes.  Students who were in the regular group did not score lower than 260, while students who were in the sports group
scored as low as 200.

#   3.What could be one additional variable that was not mentioned in the narrative that could be influencing the point 
#     distributions between the two sections?
One additional variable that could influence the distributions could be the amount of homework that was given.  If the regular
group had been given more assignments or teacher assistance than the other group (which may be less quantifiable) than it 
would provide more insight as to why there is such a gap between the two methods.  Another positibility could be the students
who are less familiar with sports that may not fully comprehend the references being made.
