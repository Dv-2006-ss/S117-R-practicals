# ==============================================================================
# 1. SETUP: Import Both CSV Files (Fixed with Manual Selection)
# ==============================================================================

# FIX: Instead of looking for a specific filename, we ask the user to pick it.
print("--- ACTION REQUIRED: Please select your FINANCE CSV file (CL_in_15...) ---")
finance_df <- read.csv(file.choose()) 

print("--- ACTION REQUIRED: Please select your CRICKET CSV file (Fastest Fifties...) ---")
cricket_df <- read.csv(file.choose())

print("--- Data Structure Before Transformation ---")
print(names(finance_df)) 
print(names(cricket_df)) 

# ==============================================================================
# 2. DATA PREPARATION (Aligning Columns)
# ==============================================================================

# 2.1 Prepare Financial Data
# Ensure we are using the exact column names from your file (lowercase 'symbol' and 'close')
finance_clean <- finance_df[, c("symbol", "close")]
names(finance_clean) <- c("Entity_Name", "Numeric_Value")

# 2.2 Prepare Cricket Data
# Ensure we are using the exact column names from your file ('Player' and 'Runs')
cricket_clean <- cricket_df[, c("Player", "Runs")]
names(cricket_clean) <- c("Entity_Name", "Numeric_Value")

# Ensure both numeric columns are actually numeric to prevent errors during binding
finance_clean$Numeric_Value <- as.numeric(finance_clean$Numeric_Value)
cricket_clean$Numeric_Value <- as.numeric(cricket_clean$Numeric_Value)

# ==============================================================================
# 3. VERTICAL COMBINATION (rbind)
# ==============================================================================

# Now that columns match exactly (Entity_Name, Numeric_Value), we can stack them.
combined_data <- rbind(finance_clean, cricket_clean)

print("--- Combined Data Summary ---")
print(paste("Finance rows:", nrow(finance_clean)))
print(paste("Cricket rows:", nrow(cricket_clean)))
print(paste("Total rows (Actual):", nrow(combined_data)))

print("--- Preview of Combined Data ---")
print(head(combined_data)) # Will show NYMEX data
print(tail(combined_data)) # Will show Cricket Player data

