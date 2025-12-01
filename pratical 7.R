# ==============================================================================
# 7.  Selecting and dropping variables using select() in R
# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================
library(dplyr) 

# Import the CSV file (Using your corrected path with the space)
cricket <- read.csv("D:/Dhairya/R/Fastest _Fifties _All _Seasons _Combine.csv")

print("--- Original Dataset (First 3 rows) ---")
print(head(cricket, 3))

# ==============================================================================
# 2. SELECTING VARIABLES (Keeping Columns)
# ==============================================================================

# Method A: Select specific columns by name
# Scenario: We only want the Player Name, Runs scored, and the Opponent (Against)
selected_cols <- cricket %>%
  select(Player, Runs, Against)

print("--- Selected Specific Columns ---")
print(head(selected_cols, 3))

# Method B: Select a range of adjacent columns
# Scenario: Select everything from 'Player' to 'BF' (Balls Faced)
range_cols <- cricket %>%
  select(Player:BF)

print("--- Selected Range of Columns ---")
print(head(range_cols, 3))

# Method C: Select using helper functions
# Scenario: Select columns that start with "R" (Runs)
starts_with_r <- cricket %>%
  select(starts_with("R"))

print("--- Selected columns starting with 'R' ---")
print(head(starts_with_r, 3))

# ==============================================================================
# 3. DROPPING VARIABLES (Removing Columns)
# ==============================================================================
# We use the minus sign (-) to remove variables

# Method A: Drop a single specific column
# Scenario: Remove the 'Venue' column
dropped_one <- cricket %>%
  select(-Venue)

print("--- Dataset with 'Venue' dropped ---")
print(names(dropped_one)) # Printing names to verify it's gone

# Method B: Drop multiple columns
# Scenario: Remove 'BF' (Balls Faced) and 'Against'
dropped_multiple <- cricket %>%
  select(-BF, -Against)

print("--- Dataset with 'BF' and 'Against' dropped ---")
print(names(dropped_multiple))

# Method C: Drop a range of columns
# Scenario: Remove everything from 'Runs' to 'BF'
dropped_range <- cricket %>%
  select(-(Runs:BF))

print("--- Dataset with range 'Runs' to 'BF' dropped ---")
print(names(dropped_range))

