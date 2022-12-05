library(ggplot2)
library(ggpubr)
library(MASS)
library(PerformanceAnalytics)

setwd(~/work)
data <- read.csv("clean_data.csv")


#visualizing the categorical and continuous variables
png('./figures/variable_distributions.png')
#categorical
gender_distribution <- data %>%
  ggplot(aes(x = gender, fill = as.factor(stroke))) +geom_bar()
hypertension_distribution <- data %>%
  ggplot(aes(x = hypertension, fill = as.factor(stroke))) +geom_bar()
heartdisease_distribution <- data %>%
  ggplot(aes(x = heart_disease, fill = as.factor(stroke))) +geom_bar()
smoking_distribution <- data %>%
  ggplot(aes(x = smoking_status, fill = as.factor(stroke))) +geom_bar()
marriage_distribution <- data %>%
  ggplot(aes(x = ever_married, fill = as.factor(stroke))) +geom_bar()
work_distribution <- data %>%
  ggplot(aes(x = work_type, fill = as.factor(stroke))) +geom_bar()
residence_distribution <- data %>%
  ggplot(aes(x = Residence_type, fill = as.factor(stroke))) +geom_bar()

#continuous
age_distribution <- data %>%
  ggplot(aes(x = age, fill = as.factor(stroke))) + geom_histogram(bins=30) +
  theme(legend.position="none")
glucose_distribution <- data %>%
  ggplot(aes(x = avg_glucose_level, fill = as.factor(stroke))) + geom_histogram(bins=30) +
  theme(legend.position="none")
bmi_distribution <- data %>%
  ggplot(aes(x = bmi, fill = as.factor(stroke))) + geom_histogram(bins=30) +
  theme(legend.position="none")

#put into the same frame
figure <- ggarrange(gender_distribution, hypertension_distribution, heartdisease_distribution,
                    smoking_distribution, marriage_distribution, residence_distribution, work_distribution,
                    age_distribution, glucose_distribution, bmi_distribution,
                    ncol = 2, nrow = 5)
figure
dev.off()




#plot the a correlation chart
png('./figures/stroke_variables.png')
#transform the data into numerics to compute a correlation chart
correlation_data <- as.data.frame(unclass(data), stringsAsFactors = TRUE)
correlation_data[sapply(correlation_data, is.factor)] <-
  data.matrix(correlation_data[sapply(correlation_data, is.factor)])
#compute the correlation chart
chart.Correlation(correlation_data)
dev.off()

#a primary PCA analysis
prin_comp <- prcomp(correlation_data, scale. = T)

png('./figures/pca.png')
biplot(prin_comp, scale = 0)
dev.off()



