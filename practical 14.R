library(lubridate)
library(dplyr)

# ==============================================================================
# 1. SETUP: Import Data (Manual Selection)
# ==============================================================================

# Select your 'CL_in_15_minute_new.csv' file
print("--- ACTION: Please select your FINANCE CSV file ---")
finance_df <- read.csv(file.choose()) 

print("--- 1. Raw Data (First few rows) ---")
print(head(finance_df$datetime))

# ==============================================================================
# 2. PARSE AND EXTRACT
# ==============================================================================

processed_data <- finance_df %>%
  mutate(
    # A. Parsing: Convert text to a real Date-Time Object
    Actual_Time = ymd_hms(datetime), 
    
    # B. Extraction Functions
    Year_Num     = year(Actual_Time),       
    Month_Name   = month(Actual_Time, label = TRUE),
    Day_Num      = day(Actual_Time),        
    Weekday_Name = wday(Actual_Time, label = TRUE, abbr = FALSE),
    
    # C. Time Specific Extractions (Crucial for 15-min data)
    Hour_Num     = hour(Actual_Time),       
    Minute_Num   = minute(Actual_Time)      
  ) %>%
  # Let's select just the new columns to verify
  select(datetime, Actual_Time, Year_Num, Weekday_Name, Hour_Num, Minute_Num)

print("--- 2. Data with Extracted Components ---")
print(head(processed_data))

# ==============================================================================
# 3. ANALYSIS EXAMPLE: Count Trades by Hour
# ==============================================================================


hourly_activity <- processed_data %>%
  group_by(Hour_Num) %>%
  count()

print("--- 3. Activity by Hour ---")
print(hourly_activity)
