# ==========================================
# Pract 6.  Merge and Append (Adapted for Cricket Data)
# ==========================================

library(dplyr) 

# ------------------------------------------
# 1. SETUP: Load Your Actual Data
# ------------------------------------------

# Read your CSV file
cricket_data <- read.csv("D:/Dhairya/R/Fastest _Fifties _All _Seasons _Combine.csv")# FOR DEMONSTRATION:

batch_1 <- head(cricket_data, 5)

batch_2 <- cricket_data[6:10, ]

# Dataset 3: Team Names Table (To practice Merging)
team_lookup <- data.frame(
  Against = c("CSK", "MI", "DEC", "RR", "PBKS"),
  Full_Team_Name = c("Chennai Super Kings", "Mumbai Indians", 
                     "Deccan Chargers", "Rajasthan Royals", "Punjab Kings")
)

print("--- Main Data Loaded ---")
print(head(cricket_data))

# ------------------------------------------
# 2. APPEND (Stacking Rows)
# ------------------------------------------

final_player_list <- bind_rows(batch_1, batch_2)

print("--- Appended Data (Rows 1-10 combined) ---")
print(final_player_list)


# ------------------------------------------
# 3. MERGE (Joining Columns)
# ------------------------------------------

merged_data <- merge(cricket_data, team_lookup, by = "Against", all.x = TRUE)

print("--- Merged Data (Full Team Names Added) ---")
# Using head() to keep the output clean
print(head(merged_data))
