# =====================================
# Logistic Regression using glm()
# Using CSV file + Graph + Export
# =====================================

# -------------------------------------
# Load required library
# -------------------------------------
library(writexl)

# -------------------------------------
# 1. Load CSV file
# -------------------------------------
data <- read.csv(file.choose())

# -------------------------------------
# 2. Check required columns
# (runs and pos must exist in CSV)
# -------------------------------------
if (!all(c("runs", "pos") %in% colnames(data))) {
  stop("CSV file must contain 'runs' and 'pos' columns")
}

# -------------------------------------
# 3. Create Binary Outcome Variable
# (Top 5 position = 1, else 0)
# -------------------------------------
data$Top5 <- ifelse(data$pos <= 5, 1, 0)
data$Top5 <- as.factor(data$Top5)

# -------------------------------------
# 4. Logistic Regression Model
# -------------------------------------
logistic_model <- glm(Top5 ~ runs,
                      data = data,
                      family = binomial)

# -------------------------------------
# 5. Show model summary
# -------------------------------------
model_summary <- summary(logistic_model)
print(model_summary)

# -------------------------------------
# 6. RESET GRAPH SETTINGS (IMPORTANT)
# -------------------------------------
par(mfrow = c(1, 1))
par(mar = c(5, 5, 4, 2))

# -------------------------------------
# 7. Logistic Regression Graph
# -------------------------------------
plot(data$runs,
     as.numeric(as.character(data$Top5)),
     main = "Logistic Regression Analysis",
     xlab = "Runs",
     ylab = "Top 5 Position (0 = No, 1 = Yes)",
     pch = 16,
     col = "darkgreen")

# Add logistic regression curve
curve(
  predict(logistic_model,
          newdata = data.frame(runs = x),
          type = "response"),
  add = TRUE,
  col = "red",
  lwd = 2
)

# -------------------------------------
# 8. Extract regression coefficients
# -------------------------------------
results_df <- as.data.frame(model_summary$coefficients)

# -------------------------------------
# 9. Export Results
# -------------------------------------

# Export to CSV
write.csv(results_df,
          "logistic_regression_results.csv",
          row.names = TRUE)

# Export to Excel
write_xlsx(results_df,
           "logistic_regression_results.xlsx")

# Export to PDF
pdf("logistic_regression_summary.pdf")
plot(data$runs,
     as.numeric(as.character(data$Top5)),
     main = "Logistic Regression Analysis",
     xlab = "Runs",
     ylab = "Top 5 Position",
     pch = 16,
     col = "darkgreen")
curve(
  predict(logistic_model,
          newdata = data.frame(runs = x),
          type = "response"),
  add = TRUE,
  col = "red",
  lwd = 2
)
dev.off()
