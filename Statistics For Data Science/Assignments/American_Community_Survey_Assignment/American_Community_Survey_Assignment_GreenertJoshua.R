# Assignment: American Community Survey Exercise
# Name: Greenert, Joshua
# Date: 6/22/2022

library(ggplot2)
setwd("C:/Users/Josh/Documents/GitHub/R-Projects/Statistics For Data Science")
american_community <- read.csv("data/acs-14-1yr-s0201.csv")

## 1.What are the elements in your data (including the categories and data types)?
# The data types are chr, int, and num.  The categories include id, id2, geography,
# PopGroupID, POPGROUP.display.label, RacesReported, HSDegree, and BachDegree.

## 2.Please provide the output from the following functions: str(); nrow(); ncol()
str(american_community)  
'data.frame':	136 obs. of  8 variables:
#  $ Id                    : chr  "0500000US01073" "0500000US04013" "0500000US04019" "0500000US06001" ...
#  $ Id2                   : int  1073 4013 4019 6001 6013 6019 6029 6037 6059 6065 ...
#  $ Geography             : chr  "Jefferson County, Alabama" "Maricopa County, Arizona" "Pima County, Arizona" "Alameda County, California" ...
#  $ PopGroupID            : int  1 1 1 1 1 1 1 1 1 1 ...
#  $ POPGROUP.display.label: chr  "Total population" "Total population" "Total population" "Total population" ...
#  $ RacesReported         : int  660793 4087191 1004516 1610921 1111339 965974 874589 10116705 3145515 2329271 ...
#  $ HSDegree              : num  89.1 86.8 88 86.9 88.8 73.6 74.5 77.5 84.6 80.6 ...
#  $ BachDegree            : num  30.5 30.2 30.8 42.8 39.7 19.7 15.4 30.3 38 20.7 ..
nrow(american_community) 
## 136
ncol(american_community) 
## 8

## 3.Create a Histogram of the HSDegree variable using the ggplot2 package
ggplot(american_community, aes(x = HSDegree)) + geom_histogram(bins = 10) + 
    ggtitle("High School Completion %") + xlab("HS Complete %") + ylab("Population")

## 4.Answer the following questions based on the Histogram produced:
# 1. This is unimodal because there is only one peak.
# 2. The graph is not symmetrical since the leans further to the right.
# 3. Since the graph leans to the right, it is not bell-shaped.
# 4. The graph produced does not meet normal distribution, so no.
# 5. The graph shows that there is a negative skew (skewed to the right).
# 6. 
ggplot(american_community, aes(x = HSDegree)) + geom_histogram(aes(y =..density..), 
 breaks = seq(50, 100, by = 5), color = "white", fill = "black") + 
  stat_function(fun = dnorm, args = list(mean = mean(american_community$HSDegree),
sd = sd(american_community$HSDegree))) + 
  ggtitle("High School Completion %") + xlab("HS Complete %") + ylab("Population")
# 7. A normal distribution curve cannot be used in this instance for accurately measuring the data in this case.
#      The typical distribution curve is based on a symmetrical bell-curve that isn't represented by the data.

## 5.Create a Probability Plot of the HSDegree variable.
plot(american_community$HSDegree)

## 6.Answer the following questions based on the Probability Plot:
# 1. The probability plot distribution is similar to a normal distribution since it's symmetrical.  However,
#    it does have some outliers that skew the dataset.
# 2. The distribution of the plot points appears normal with a few outliers and matches a bell curve.

## 7.Now that you have looked at this data visually for normality, you will now quantify normality with numbers 
##   using the stat.desc() function. Include a screen capture of the results produced.
##   Screenshot saved in GitHub folder with files.
library(pastecs)
stat.desc(american_community$HSDegree, basic=TRUE, desc=TRUE, norm=FALSE, p=0.95)

## 8.In several sentences provide an explanation of the result produced for skew, kurtosis, and z-scores. 
##   In addition, explain how a change in the sample size may change your explanation?
# Skew
# As we can see from the results, the skew is marked at approximately -1.67.  The closer the skew is to 0
# means that the data is closer to normal distribution.  The further the skew is away from 0 means that a
# normal distribution is less likely.  In this case, the skew is negative.  Therefore, we would expect values
# to be distributed along the right-hand side of the graph.

# Kurtosis
# As we can see from the results, the kurtosis is marked at appromately 4.35.  With such a positive value, we
# can assume that our data will provide a heavy-tailed distribtution; essentially, this means that the data
# goes to zero slower than data with an exponential tail.  These types of distributions tend to have heavy
# outliers while also, potentially, larger values in the dataset.  In other words, if samples were picked from
# the dataset at random, they may skew the statistics.  Likewise, the mean derived from the data would be heavily
# misleading about what the data represents.

# Z-scores
# Z-scores, or normal scores, are values that are able to determine the distance from the mean of the dataset.  This
# measurement is generally found by taking a sample from the data, subtracting the mean, then dividing it by the 
# standard deviation.  For our values, we can use ID 0500000US06065
(80.6 - 87.63) / 5.12 = -1.37
# In this example, the z-score is negative which indicates that the data would land on the left-side of the normal
# distribution curve.  Using this data, we can determine where the sample falls in comparison to the overall dataset.
# A change in the sample size here would provide more clarity, since only one was used for this z-score, that could
# better determine the scope of the z-score, and where it should fall with regards to the overall mean and standard
# deviation.
