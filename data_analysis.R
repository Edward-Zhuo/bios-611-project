library(ggplot2)
library(ggpubr)
library(MASS)
library(pROC)

data <- read.csv("clean_data.csv")

lda_results <- lda(stroke~.,data=data)
lda_results

#plot the data first
png('./figures/stroke_variables.png')
plot(data)
dev.off()


#visualizing the categorical variables
png('./figures/d_variable_distributions.png')
gender_distribution <- data %>%
  ggplot(aes(x = gender, fill = as.factor(stroke))) +geom_bar()
hypertension_distribution <- data %>%
  ggplot(aes(x = hypertension, fill = as.factor(stroke))) +geom_bar()
heartdisease_distribution <- data %>%
  ggplot(aes(x = heart_disease, fill = as.factor(stroke))) +geom_bar()
marriage_distribution <- data %>%
  ggplot(aes(x = ever_married, fill = as.factor(stroke))) +geom_bar()
work_distribution <- data %>%
  ggplot(aes(x = work_type, fill = as.factor(stroke))) +geom_bar()
residence_distribution <- data %>%
  ggplot(aes(x = Residence_type, fill = as.factor(stroke))) +geom_bar()
smoking_distribution <- data %>%
  ggplot(aes(x = smoking_status, fill = as.factor(stroke))) +geom_bar()

figure <- ggarrange(gender_distribution, hypertension_distribution, heartdisease_distribution,
                    marriage_distribution, work_distribution, residence_distribution,
                    smoking_distribution,
                    ncol = 2, nrow = 4)
figure
dev.off()

#visualizing the continuous variables
png('./figures/c_variable_distributions.png')
age_distribution <- data %>%
  ggplot(aes(x = age, fill = as.factor(stroke))) + geom_histogram(bins=30) +
  theme(legend.position="none")
glucose_distribution <- data %>%
  ggplot(aes(x = avg_glucose_level, fill = as.factor(stroke))) + geom_histogram(bins=30) +
  theme(legend.position="none")
bmi_distribution <- data %>%
  ggplot(aes(x = bmi, fill = as.factor(stroke))) + geom_histogram(bins=30) +
  theme(legend.position="none")

figure <- ggarrange(age_distribution, glucose_distribution, bmi_distribution,
                    ncol = 2, nrow = 2)
figure
dev.off()

#fit a logistic model with the age variables
train_test_data <- data %>% mutate(train=runif(nrow(.)) < 0.75)
train <- train_test_data %>% filter(train) %>% dplyr::select(-train)
test <- train_test_data %>% filter(!train) %>% dplyr::select(-train)

logistic_model <- glm(stroke ~ . , family =binomial, data = train);

test$stroke_pred <- predict(logistic_model, newdata = test, type = "response")



#plot the ROC curve
png('./figures/roc.png')
roc_obj <- roc(test$stroke,test$stroke_pred)
plot(roc_obj)
dev.off()
