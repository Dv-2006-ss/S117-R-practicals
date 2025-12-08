library(dplyr)
library(tidyr)

# ==============================================================================
# 1. SETUP: Create and Import Data
# ==============================================================================

df <- read.csv(file.choose(), na.strings = c("", "NA"))
  mutate(RowIndex = row_number()) %>%  # Created a RowIndex to track lines
  select(RowIndex, datetime, symbol, open, high, low, close, volume)

print("--- 1. Original Wide Data ---")
print(head(df))

# ==============================================================================
# 2. PIVOT_LONGER (Wide to Long)
# ==============================================================================

# Combine 'open', 'high', 'low', 'close' into a single 'Price' column
# This is useful for plotting multiple price lines on one graph in ggplot2
long_df <- df %>%
  pivot_longer(
    cols = c(open, high, low, close),
    names_to = "PriceType",  # This will contain "open", "high", etc.
    values_to = "Price"      # This will contain the numeric values
  )

print("--- 2. Long Format (pivot_longer) ---")
print(head(long_df, 10))

# ==============================================================================
# 3. PIVOT_WIDER (Long to Wide)
# ==============================================================================

# Converting back to the original OHLC format
wide_df <- long_df %>%
  pivot_wider(
    names_from = PriceType,
    values_from = Price
  )

print("--- 3. Wide Format (Back to Original) ---")
print(head(wide_df))

# ==============================================================================
# 4. ADVANCED EXAMPLE (Reshaping for Reporting)
# ==============================================================================

# Scenario: Creating a "Time Series Matrix" where columns are Symbols
# (Useful if your data had multiple symbols like NYMEX:CL, AAPL, GOOGL)

# We isolate just the closing price for comparison
category_pivot <- df %>%
  select(datetime, symbol, close) %>%
  pivot_wider(
    names_from = symbol,
    values_from = close
  )

print("--- 4. Symbol Pivot (Spreading Symbols) ---")
print(head(category_pivot))
