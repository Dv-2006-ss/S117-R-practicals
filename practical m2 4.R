# Load required library
library(dplyr)

# Read the CSV file
df <- read.csv(file.choose(), stringsAsFactors = TRUE)

# View data
head(df)

# ---------------------------------------------
# One-Sample t-test
# ---------------------------------------------

# Null Hypothesis (H0):
# The mean close price is equal to the overall mean close price

print("One-Sample t-test for Close Price")
t_test_close <- t.test(df$close, mu = 80)
print(t_test_close)

t_test_volume <- t.test(df$volume, mu = 100000)
print(t_test_volume)
