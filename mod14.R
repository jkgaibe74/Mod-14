# Module 4 - Programming structure in R
# load library
library("ggplot2")
library("tidyverse")
library("reshape2")

freq <- c(0.6, 0.3, 0.4, 0.4, 0.2, 0.6, 0.3, 0.4, 0.9, 0.2)
bloodp <- c(103, 87, 32, 42, 59, 109, 78, 205, 135, 176)
first <- c(1, 1, 1, 1, 0, 0, 0, 0, NA, 1)  # Convert "bad" to 0 and "good" to 1
second <- c(0, 0, 1, 1, 0, 0, 1, 1, 1, 1)  # Convert "low" to 0 and "high" to 1
finaldecision <- c(0, 1, 0, 1, 0, 1, 0, 1, 1, 1)

#histograms
ggplot(df, aes(x = bloodp, y = freq , fill = variable)) +
  geom_bar(stat = "identity", position = 'stack', fill = "red", color = "black", alpha = 1) +
  labs(title = "Distribution of Blood Pressure", x = "Blood Pressure", y = "Frequency")

#creating two separate panels of a histogram to present the first and second assessment. 
#First convert to long format
df_long <- melt(df, id.vars = c("freq", "bloodp", "finaldecision"), variable.name = "Variable", value.name = "Value")
#creating the histogram
ggplot(df_long, aes(x = bloodp, y = freq, fill = as.factor(Value))) +
  geom_bar(stat = "identity", position = "stack", color = "black", alpha = 1) +
  labs(title = "Distribution of Blood Pressure",
       x = "Blood Pressure",
       y = "Frequency") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), name = "Final Decision",
                    labels = c("Low", "High")) +  # label name
  facet_wrap(~Variable, scales = "free_y", nrow = 2) #using facet_wrap to create two separate panels for each first and second assessments

#boxplot
# Create a boxplot using ggplot2
ggplot(df, aes(x = factor(finaldecision), y = bloodp)) +
  geom_boxplot(fill = "red", color = "black") +
  labs(title = "Blood Pressure by Final Decision", x = "Final Decision", y = "Blood Pressure")
