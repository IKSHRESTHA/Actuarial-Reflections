# Load required libraries
library(caret)       # For data splitting and model evaluation
library(rpart)       # For decision tree
library(rpart.plot)  # For visualizing the tree
library(dplyr)       # For data manipulation

# 1. Data Preparation
# Convert character variables to factors (required for classification)
df <- df %>%
  mutate(across(where(is.character), as.factor))

# 2. Train-Test Split (70% train, 30% test)
set.seed(123) # For reproducibility
train_index <- createDataPartition(df$personality, p = 0.7, list = FALSE)
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

# 3. Build Decision Tree Model
tree_model <- rpart(
  personality ~ ., 
  data = train_data, 
  method = "class",
  control = rpart.control(
    minsplit = 20,    # Minimum number of obs to split
    cp = 0.01,        # Complexity parameter
    maxdepth = 5      # Maximum depth of tree
  )
)

# 4. Visualize the Decision Tree
rpart.plot(tree_model, 
           box.palette = "BuRd", # Color scheme
           shadow.col = "gray",  # Shadow under node boxes
           nn = TRUE)           # Show node numbers

# 5. Model Evaluation

# Predict on training data (to check for overfitting)
train_pred <- predict(tree_model, train_data, type = "class")
train_confusion <- confusionMatrix(train_pred, train_data$personality)
print("Training Set Performance:")
print(train_confusion)

# Predict on test data
test_pred <- predict(tree_model, test_data, type = "class")
test_confusion <- confusionMatrix(test_pred, test_data$personality)
print("Test Set Performance:")
print(test_confusion)

# 6. Additional Metrics
# Variable Importance
importance <- varImp(tree_model)
print("Variable Importance:")
print(importance)

# Classification Error Rate
test_error <- 1 - test_confusion$overall["Accuracy"]
print(paste("Test Error Rate:", round(test_error, 4)))

# 7. ROC Curve (for binary classification)
if(length(levels(df$personality)) == 2) {
  library(pROC)
  test_prob <- predict(tree_model, test_data, type = "prob")[,2]
  roc_curve <- roc(test_data$personality, test_prob)
  plot(roc_curve, main = "ROC Curve", col = "#1c61b6")
  auc(roc_curve)
}
--------------------
# ----------------------------
# 1. Load Required Libraries
# ----------------------------

library(caret)        # For ML pipeline
library(rpart)        # Decision tree algorithm
library(rpart.plot)   # Tree visualization
library(pROC)         # ROC curve analysis
library(dplyr)        # Data manipulation

# ----------------------------
# 2. Data Preparation
# ----------------------------
# Convert character variables to factors
df <- df %>%
  mutate(across(where(is.character), as.factor))

# Check for missing values (critical for decision trees)




# ----------------------------
# 3. Train-Test Split (70-30)
# ----------------------------
set.seed(123)
train_index <- createDataPartition(df$personality, p = 0.7, list = FALSE)
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

# ----------------------------
# 4. Parameter Tuning (Grid Search with 10-Fold CV)
# ----------------------------
tune_control <- trainControl(
  method = "cv",
  number = 10,
  summaryFunction = defaultSummary,
  classProbs = TRUE,
  savePredictions = "final"
)

tune_grid <- expand.grid(
  cp = seq(0.001, 0.05, length.out = 10),  # Complexity parameter
  minsplit = c(10, 20, 30),                 # Min observations to split
  maxdepth = c(3, 5, 7)                     # Tree depth limits
)

# Run tuning
set.seed(123)
tuned_model <- train(
  personality ~ .,
  data = train_data,
  method = "rpart",
  trControl = tune_control,
  tuneGrid = tune_grid,
  metric = "Accuracy"
)

# Best parameters
print("Optimal Parameters:")
print(tuned_model$bestTune)

# ----------------------------
# 5. Train Final Model with Best Parameters
# ----------------------------
final_tree <- rpart(
  personality ~ .,
  data = train_data,
  method = "class",
  control = rpart.control(
    cp = tuned_model$bestTune$cp,
    minsplit = tuned_model$bestTune$minsplit,
    maxdepth = tuned_model$bestTune$maxdepth
  )
)

# ----------------------------
# 6. Model Evaluation
# ----------------------------
# Training set performance
train_pred <- predict(final_tree, train_data, type = "class")
train_cm <- confusionMatrix(train_pred, train_data$personality)

# Test set performance
test_pred <- predict(final_tree, test_data, type = "class")
test_cm <- confusionMatrix(test_pred, test_data$personality)

# Print results
print("Training Performance:")
print(train_cm)
print("Test Performance:")
print(test_cm)

# ----------------------------
# 7. Advanced Metrics
# ----------------------------
# Variable Importance
var_imp <- varImp(final_tree)
print("Variable Importance:")
print(var_imp)

# ROC Curve (for binary classification)
test_probs <- predict(final_tree, test_data, type = "prob")[,2]
roc_result <- roc(test_data$personality, test_probs)
plot(roc_result, main = "ROC Curve", col = "blue")
auc_value <- auc(roc_result)
print(paste("AUC:", round(auc_value, 3)))

# ----------------------------
# 8. Visualization
# ----------------------------
# Decision Tree Plot
prp(final_tree,
    box.palette = "Blues",
    shadow.col = "gray",
    nn = TRUE,
    fallen.leaves = TRUE,
    branch = 0.5,
    faclen = 0,  # Use full factor names
    extra = 104) # Show probabilities and observations