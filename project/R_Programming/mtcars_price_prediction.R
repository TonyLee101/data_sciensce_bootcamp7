library(tidyverse)
library(caret)

#Train Test Split 
#1. Split Data
#2. Train Data
#3. Score
#4. Evaluate

glimpse(mtcars)

#Caret = Classification And REgression Tree

#Train Test Split 
#1. Split Data
#Split Data 80%: 20%
train_test_split <- function(data, train_ratio = 0.7) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(1 : n, size = train_ratio * n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return( list(train = train_data, test = test_data) )
}

split_data <- train_test_split(mtcars, 0.7)
train_data <- split_data[[1]]
test_data <- split_data[[2]]

#2. Train Data
#mpg = f(hp, wt, am)
#method = Algorithm
set.seed(42)

#Change Resampling Method (LOOCV, boot, cv) *USE cv
ctrl <- trainControl(
  method = "cv", #Golden Standard
  number = 5, #K = 5
  verboseIter = TRUE 
)

#Linear Regression Model
lm_model <- train(mpg ~ hp + wt + am, data = train_data, method = "lm", trControl = ctrl)

#Random Forest Model
rf_model <- train(mpg ~ hp + wt + am, data = train_data, method = "rf", trControl = ctrl)

#K-Nearest Neighbors Model
knn_model <- train(mpg ~ hp + wt + am, data = train_data, method = "knn", trControl = ctrl)

#In this scenario: rf > lm > knn

#3. Score
p_lm <- predict(lm_model, newdata = test_data)
p_rf <- predict(rf_model, newdata = test_data)
p_knn <- predict(knn_model, newdata = test_data)

#4. Evaluate
#MAE, MSE, RMSE

#Mean Absolute Error
MAE <- function(actual, prediction) {
  abs_error <- abs(actual - prediction)
  mean(abs_error)
}

#Mean Squared Error
MSE <- function(actual, prediction) {
  sq_error <- (actual - prediction) ** 2
  mean(sq_error)
}

#Root Mean Squared Error
RMSE <- function(actual, prediction) {
  sq_error <- (actual - prediction) ** 2
  sqrt(mean(sq_error))
}

RMSE(test_data$mpg, p_lm)
RMSE(test_data$mpg, p_rf)
RMSE(test_data$mpg, p_knn)

#5. Save Model
saveRDS(model, "linear_regression_v1.RDS")
