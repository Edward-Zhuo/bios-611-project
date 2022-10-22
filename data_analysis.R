library(ggplot2)


data <- read.csv("clean_data.csv")

#visualizing the continuous variables
png('./figures/variables.png')
par(mfrow=c(2,2))
hist(data$age)
hist(data$avg_glucose_level)
hist(data$bmi)
dev.off()

#fit a linear model with the age variables
logistic_model <- glm(stroke ~ age, data=data, family=binomial)
Predicted_data <- data.frame(age=seq(min(data$age), max(data$age),len=5110))
Predicted_data$stroke = predict(logistic_model, Predicted_data, type="response")
png('./figures/lm_age.png')
plot(stroke ~ age, data=data)
lines(stroke~ age, Predicted_data, col="green")
dev.off()