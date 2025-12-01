# ==============================================================================
# R Script: String Manipulation on Cricket Data
# ==============================================================================


library(stringr)
library(tidyr)
library(dplyr)

# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================
# Using your corrected file path
cricket <- read.csv("D:/Dhairya/R/Fastest _Fifties _All _Seasons _Combine.csv")

print("--- Original Dataset (First 3 rows) ---")
print(head(cricket %>% select(Player, Venue, Match.Date), 3))

# ==============================================================================
# 2. USING str_sub() (Substring)
# ==============================================================================
# Scenario: We want to create a short "Stadium Code" from the Venue name.
# We will take the first 3 letters of the Venue.

# Extract the first 3 characters
cricket$Venue_Code <- str_sub(cricket$Venue, 1, 3)

# Extract the last 4 characters from Match Date (to get the Year quickly)
cricket$Year_Extracted <- str_sub(cricket$Match.Date, -4, -1)

print("--- Data after str_sub() ---")
print(head(cricket %>% select(Venue, Venue_Code, Year_Extracted), 3))

# ==============================================================================
# 3. USING str_split() (Split String)
# ==============================================================================
# Scenario: The 'Match.Date' is in format "24 April 2008".
# We want to split this into three parts.

# simplify = TRUE returns a matrix so we can grab specific columns easily
split_matrix <- str_split(cricket$Match.Date, " ", simplify = TRUE)

# Assign the split parts to new columns
cricket$Day   <- split_matrix[, 1] # First part (e.g., "24")
cricket$Month <- split_matrix[, 2] # Second part (e.g., "April")
# Note: The third part might vary if the date format isn't perfect, but usually it's Year.

print("--- Data after str_split() ---")
print(head(cricket %>% select(Match.Date, Day, Month), 3))


# ==============================================================================
# 4. BONUS: The "Tidy" Way (separate)
# ==============================================================================
# This is the easiest way to split columns in a real project.
# We will split 'Match.Date' into 3 clean columns automatically.

tidy_cricket <- cricket %>%
  separate(Match.Date, into = c("Date_Day", "Date_Month", "Date_Year"), sep = " ")

print("--- Bonus: The 'separate' function ---")
print(head(tidy_cricket %>% select(Date_Day, Date_Month, Date_Year), 3))

