install.packages("dplyr")

library(dplyr)
library(readr) 

# --- 1. Load your specific CSV file ---
# This will open a window. Select your 'CL_in_15_minute_new.csv'
market_data <- read_csv(file.choose())

# Quick look to confirm the data loaded correctly
head(market_data)

# ==========================================
# Method 1: Using subset() (Base R)
# ==========================================

# Example 1: Single Condition
# Professor's logic: Filter for value > X
# Adapted for you: Filter rows where 'close' price is greater than 69.40
high_value_subset <- subset(market_data, close > 69.40)

cat("Number of high close values (close > 69.40):", nrow(high_value_subset), "\n")
summary(high_value_subset$close)


# Example 2: Multiple Conditions (AND)
# Professor's logic: Condition A AND Condition B
# Adapted for you: 'close' > 69.40 AND 'volume' < 100
low_vol_high_val_subset <- subset(market_data, close > 69.40 & volume < 100)

cat("Number of rows with close > 69.40 and volume < 100:", nrow(low_vol_high_val_subset), "\n")
head(low_vol_high_val_subset)


# Example 3: Multiple Conditions (OR)
# Professor's logic: Condition A OR Condition B
# Adapted for you: 'open' < 69.20 OR 'volume' > 500
special_subset <- subset(market_data, open < 69.20 | volume > 500)

cat("Number of special rows (open < 69.20 OR volume > 500):", nrow(special_subset), "\n")
head(special_subset)


# ==========================================
# Method 2: Using filter() (dplyr package)
# ==========================================

# Example 1: Single Condition (Using Pipe Operator |>)
# Adapted for you: Filter for 'volume' less than 200
low_vol_filter <- market_data |>
  filter(volume < 200)

cat("Number of rows with volume < 200:", nrow(low_vol_filter), "\n")
summary(low_vol_filter$volume)


# Example 2: Multiple Conditions (Comma-Separated = AND)
# Adapted for you: 'high' > 69.50 AND 'volume' > 300
high_vol_high_price_filter <- market_data |>
  filter(high > 69.50, volume > 300)

cat("Rows where high > 69.50 and volume > 300:", nrow(high_vol_high_price_filter), "\n")
head(high_vol_high_price_filter)


# Example 3: Checking for Values in a Set (%in%)
# Professor's logic: Filter where a column matches a specific list of values
# Adapted for you: Filter where 'symbol' is exactly "NYMEX:CL" or "NYMEX:CL1!"
symbol_filter <- market_data |>
  filter(symbol %in% c("NYMEX:CL", "NYMEX:CL1!"))

cat("Number of rows with specific symbols:", nrow(symbol_filter), "\n")
head(symbol_filter)

