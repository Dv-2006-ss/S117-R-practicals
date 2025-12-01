# Load necessary libraries
library(dplyr)
library(tidyr) # Contains replace_na()

# ==============================================================================
# 1. CREATE AND IMPORT DATASET
# ==============================================================================

# Note: 'na.strings = ""' tells R to treat empty spaces as NA (Missing Values).

# Read your dataset from the correct path
cricket_df <- read.csv("D:/Dhairya/R/Fastest _Fifties _All _Seasons _Combine.csv", na.strings = c("", "NA"))

print("--- 1. Original Data (First 6 Rows) ---")
print(head(cricket_df))

# Check how many NAs are in each column
print("--- Count of Missing Values per Column ---")
print(colSums(is.na(cricket_df)))

# ==============================================================================
# 2. METHOD A: REMOVE MISSING VALUES (na.omit)
# ==============================================================================
# This is the "nuclear option". If a row has even ONE missing value, it is deleted.

clean_omit <- na.omit(cricket_df)

print("--- 2. Data after na.omit() ---")
print(paste("Original rows:", nrow(cricket_df)))
print(paste("Rows remaining:", nrow(clean_omit)))
print(head(clean_omit))


# ==============================================================================
# 3. METHOD B: REPLACE MISSING VALUES (replace_na)
# ==============================================================================
# This is the "surgical option". We fill missing values with logical defaults.
# Strategy:
# 1. Venue: Fill missing with "Unknown Venue"
# 2. 6s (Sixes): Fill missing with 0 (Assumption: No data = 0 sixes)
# 3. Runs: Fill missing with the Mean (Average) Runs

# Calculate average runs (ignoring NAs) to use for filling
avg_runs <- mean(cricket_df$Runs, na.rm = TRUE)

clean_replace <- cricket_df %>%
  replace_na(list(
    Venue = "Unknown Venue",
    X6s = 0,         # Note: R might rename '6s' to 'X6s' automatically
    Runs = avg_runs
  ))

print("--- 3. Data after replace_na() ---")
print(head(clean_replace))

# Verify no NAs exist in the columns we cleaned
print("--- Remaining NAs after replacement ---")
print(colSums(is.na(clean_replace)))