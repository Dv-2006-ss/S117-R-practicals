# -------------------------------------
# Load required library
# -------------------------------------
library(writexl)

# -------------------------------------
# 1. Load CSV file
# -------------------------------------
data <- read.csv(file.choose())

# -------------------------------------
# 2. Select numeric columns only
# -------------------------------------
numeric_data <- data[sapply(data, is.numeric)]

# Check if enough numeric columns exist
if (ncol(numeric_data) < 2) {
  stop("Dataset must contain at least two numeric columns")
}

# -------------------------------------
# 3. Linear Regression Model
# (Dependent ~ Independent)
# -------------------------------------
model <- lm(numeric_data[[1]] ~ numeric_data[[2]])

# -------------------------------------
# 4. Show statistical summary
# -------------------------------------
model_summary <- summary(model)
print(model_summary)

# -------------------------------------
# 5. Extract regression coefficients
# -------------------------------------
results_df <- as.data.frame(model_summary$coefficients)

# -------------------------------------
# 6. RESET GRAPH SETTINGS (IMPORTANT FIX)
# -------------------------------------
par(mfrow = c(1, 1))      # ONE plot only
par(mar = c(5, 5, 4, 2))  # Proper margins

# -------------------------------------
# 7. Plot Linear Regression Graph
# -------------------------------------
plot(numeric_data[[2]], numeric_data[[1]],
     main = "Linear Regression Analysis",
     xlab = colnames(numeric_data)[2],
     ylab = colnames(numeric_data)[1],
     pch = 16,
     col = "darkgreen",
     cex = 1.4)

# Add regression line
abline(model, col = "red", lwd = 2)

# -------------------------------------
# 8. Export results to Excel
# -------------------------------------
write_xlsx(results_df, "Regression_Results.xlsx")
