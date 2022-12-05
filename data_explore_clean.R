library(readxl)
library(tidyverse)
library(dplyr)

setwd("~/work")
data <- read.csv("source_data/healthcare-dataset-stroke-data.csv")

#take a look at the data set in general
colnames(data)
head(data)
cat(sprintf("The dataset contains the following %d variables: %s. \n", 
            ncol(data), paste(colnames(data), collapse = ", ")), 
    file="data_explore.txt", append = FALSE);


#take a closer look at each of the variables
summary(data$id)

#First look at the discrete (categorical) variables
cat(sprintf("Let us first take a look at the discrete (categorical) covariates. "), 
    file="data_explore.txt", append = TRUE);

table(data$gender)
data<-subset(data, gender!="Other") # only one non-binary gender, not large enough sample size.
cat(sprintf("There are %d females, %d males in the dataset. ", 
            table(data$gender)[1],table(data$gender)[2]), 
    file="data_explore.txt", append = TRUE);


table(data$hypertension)
cat(sprintf("There are %d without hypertension, %d with hypertension in the dataset. ", 
            table(data$hypertension)[1],table(data$hypertension)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$heart_disease)
cat(sprintf("There are %d without heart disease, %d with heart disease in the dataset. ", 
            table(data$heart_disease)[1],table(data$heart_disease)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$smoking_status)
cat(sprintf("For the smoking status, %d formerly smoked, %d never smoked, %d smokes, and %d are unknown. ", 
            table(data$smoking_status)[1],table(data$smoking_status)[2],table(data$smoking_status)[3],
            table(data$smoking_status)[4]), 
    file="data_explore.txt", append = TRUE);


table(data$ever_married)
cat(sprintf("%d never have marriage, %d have in the dataset. ", 
            table(data$ever_married)[1],table(data$ever_married)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$Residence_type)
cat(sprintf("%d live in rural area, and %d live in urban area.", 
            table(data$Residence_type)[1],table(data$Residence_type)[2]), 
    file="data_explore.txt", append = TRUE);

table(data$work_type)
cat(sprintf("For the work type, %d are children, %d have government jobs, %d never worked, %d work for private enterprise, and %d are self-employed. ", 
            table(data$work_type)[1],table(data$work_type)[2],table(data$work_type)[3],
                                     table(data$work_type)[4],table(data$work_type)[5]), 
    file="data_explore.txt", append = TRUE);




#Then look at the continuous variables
cat(sprintf("\nLet us then take a look at the continuous covariates. "), 
    file="data_explore.txt", append = TRUE);

summary(data$avg_glucose_level)
sum_glucose=summary(data$avg_glucose_level)
cat(sprintf("For the avaerage blood glucose level, the minimum is %s and the maximum is %s. The median is %s, which is clearly less than the mean %s, indicating that the distribution is right skewed. ", 
            sum_glucose[1],sum_glucose[6],
            sum_glucose[3],round(sum_glucose[4], digits=2)), 
    file="data_explore.txt", append = TRUE);

#clean up the bmi column 
data['bmi'][data['bmi']=="N/A"] = NA
data$bmi = as.numeric(data$bmi) 
summary(data$bmi)
sum_bmi=summary(data$bmi)
data<-na.omit(data)
cat(sprintf("For the body mass index, the minimum is %s and the maximum is %s. The median is %s, which is slighly less than the mean %s, indicating that the distribution is also somewhat right skewed. There is also %s NA in the bmi data. ", 
            sum_bmi[1],sum_bmi[6],
            sum_bmi[3],round(sum_bmi[4], digits=2), sum_bmi[7]), 
    file="data_explore.txt", append = TRUE);

summary(data$age)
sum_age=summary(data$age)
cat(sprintf("For the age, the minimum is %s and the maximum is %s. The median is %s, which is slightly larger than the mean %s, indicating that the distribution is a little left skewed. ", 
            sum_age[1],sum_age[6],
            sum_age[3],round(sum_age[4], digits=2)), 
    file="data_explore.txt", append = TRUE);



table(data$stroke)
cat(sprintf("\nFinally, for the response variable, %d people in the dataset have stroke, while %d do not. ", 
            table(data$stroke)[2],table(data$stroke)[1]), 
    file="data_explore.txt", append = TRUE);


#id will not help our analysis, so might as well remove this column
data <- data %>% dplyr::select(-id)


write_csv(data, "clean_data.csv")
