# Load required libraries
library(psych)
library(dplyr)

# Load CSV file
df <- read.csv(file.choose())

# View dataset
head(df)

# =========================================================
# 1 Practical : Generating descriptive statistics
# =========================================================

print("--- 1. Descriptive Statistics ---")

# A. Using Base R summary()
# Good for: Min, Median, Mean, Max
print("Summary of Close Price:")
summary(df$close)

print("Summary of Trading Volume:")
summary(df$volume)

# B. Using psych::describe()
# Good for: Mean, SD, Skewness, Kurtosis
print("Detailed Description of Close Price:")
describe(df$close)

print("Detailed Description of Trading Volume:")
describe(df$volume)

