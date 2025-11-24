# Load the dplyr package
library(dplyr)

# By default, arrange() sorts the data in ascending order
# Example 1: Sorting by a Single Variable
# Let's sort the market_data by 'volume' from the lowest value to the highest.

# Sort by VOLUME in ascending order (lowest to highest)
market_sorted_vol <- market_data |> 
  arrange(volume)

# Check the first 5 rows—notice the low volume values
head(market_sorted_vol, 5)

# sort the data in descending order
# Example 2: Sorting by a Single Variable
# Find the rows with the highest prices ('high').

# Sort by HIGH in descending order (highest to lowest)
market_sorted_high_desc <- market_data |> 
  arrange(desc(high))

# Check the first 5 rows—notice the high price values
head(market_sorted_high_desc, 5)

# Sorting by Multiple Columns
# Example 3: Sorting by Two Variables
# Sort first by 'high' price (ascending), and for ties, sort by 'volume' (descending).
# 1. Primary Sort: high (Low to High)
# 2. Secondary Sort (Tie Breaker): volume (Highest to Lowest)

# Primary sort: HIGH (Ascending)
# Secondary sort: VOLUME (Descending, highest first)
market_multi_sort <- market_data |> 
  arrange(high, desc(volume))

# The results show lower prices first, but if prices are equal, higher volume comes first.
head(market_multi_sort, 5)

# Example 4: Combined Filter and Sort
# The real power of dplyr is chaining operations.
# Here, we use the logic from your screenshot: filter for high price > 69.50 AND volume > 300.
# Then, we sort those results by 'high' in descending order.

# Filter for high price and volume, then arrange by price
high_vol_high_price_sorted <- market_data |> 
  filter(high > 69.50, volume > 300) |> 
  arrange(desc(high))

cat("Rows where high > 69.50 and volume > 300 (Sorted by High Price):\n")
# Check the columns for confirmation
print(high_vol_high_price_sorted |> head(5))