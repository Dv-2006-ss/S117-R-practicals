# ==============================================================================
# 1. SETUP: Load Data
# ==============================================================================
# Opens a window to select 'CL_in_15_minute_new.csv'
finance_df <- read.csv(file.choose()) 

print("--- 1. Raw Data (First few rows) ---")
print(head(finance_df))
print("------Data Loaded---")

print("--- OUTPUT OF str() ---")
# This shows you the structure (int, num, chr)
str(finance_df) 

print("--- OUTPUT OF summary() [Before Factor Conversion] ---")
summary(finance_df)

# ==============================================================================
# 2. FACTOR CONVERSION
# ==============================================================================
# Converting 'symbol' (e.g., NYMEX:CL) from text (chr) to a Category (factor)
finance_df$symbol <- as.factor(finance_df$symbol)

print("--- OUTPUT OF summary() [After Factor Conversion] ---")
# Notice how 'symbol' now shows a count of rows instead of just "Length:..."
summary(finance_df)

# ==============================================================================
# 3. CALCULATIONS
# ==============================================================================

# Calculate Average Volume (Replacing 'Rating')
avg_volume <- mean(finance_df$volume, na.rm = TRUE)

# Calculate Highest Closing Price (Replacing 'Price')
max_price <- max(finance_df$close, na.rm = TRUE) 

print(paste("Average Volume:", round(avg_volume, 2)))
print(paste("Highest Closing Price:", max_price))