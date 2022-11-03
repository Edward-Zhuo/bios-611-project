library(readxl)
library(tidyverse)
library(dplyr)

setwd("~/work")
data <- read.csv("source_data/healthcare-dataset-stroke-data.csv")

#take a look at the data set in general
colnames(data)
head(data)
cat(sprintf("The dataset contains the following variables: %s \n", 
            paste(colnames(data), collapse = ", ")), 
    file="data_explore.txt", append = FALSE);

#take a closer look at each of the variables
summary(data$id)

table(data$gender)

summary(data$age)

table(data$hypertension)
table(data$heart_disease)
table(data$ever_married)
table(data$work_type)
table(data$Residence_type)

summary(data$avg_glucose_level)

#clean up the bmi column 
data['bmi'][data['bmi']=="N/A"] = NA
data$bmi = as.numeric(data$bmi)
summary(data$bmi)


table(data$smoking_status)
table(data$stroke)
cat(sprintf("%d people in the dataset have stroke, while %d do not.", 
            table(data$stroke)[2],table(data$stroke)[1]), 
    file="data_explore.txt", append = TRUE);


#id will not help our analysis, so might as well remove this column
data <- data %>% dplyr::select(-id)


write_csv(data, "clean_data.csv")
