library(dplyr)
library(tidyr) 

# ==============================================================================
# 1. SETUP: Import the Dataset
# ==============================================================================

# FIX 1: Updated file name (removed extra spaces based on your folder screenshot)
# Verify if your file is "Fastest_Fifties..." or "Fastest _Fifties..." 
# I am using the one that likely matches your Windows folder structure.
df <- read.csv("D:/Dhairya/R/Fastest _Fifties_All_Seasons_Combine.csv", na.strings = c("", "NA"))

# Check the actual column names to see if R renamed '6s' to 'X6s'
print("--- Actual Column Names ---")
print(names(df))

# PRE-CLEANING:
# We fill missing Runs, BF, and 6s with 0.
df_clean <- df %>%
  mutate(
    Runs = replace_na(Runs, 0),
    BF = replace_na(BF, 0),
    
    # FIX 2: Changed `6s` to X6s 
    # (R usually adds 'X' to columns starting with numbers)
    X6s = replace_na(X6s, 0)  
  )

print("--- Cleaned Baseline Data ---")
print(head(df_clean))

#==============================================================================
# 2. METHOD A: ARITHMETIC CALCULATIONS
#==============================================================================
# Scenario: Calculate the 'Strike Rate'.
# Formula: (Runs / Balls Faced) * 100

df_calc <- df_clean %>%
  mutate(
    # We round it to 2 decimal places to look nice
    Strike_Rate = round((Runs / BF) * 100, 2)
  )

print("--- Method A: Arithmetic Results (Strike Rate) ---")
print(head(df_calc %>% select(Player, Runs, BF, Strike_Rate)))

#==============================================================================
# 3. METHOD B: CONDITIONAL LOGIC (ifelse)
#==============================================================================
# Scenario: Label the inning based on speed and boundaries.
# Logic 1: If Strike Rate > 200, it's "Explosive", otherwise "Standard".
# Logic 2: If they hit more than five 6s, they are a "Power Hitter".

df_logic <- df_calc %>%
  mutate(
    Inning_Type = ifelse(Strike_Rate > 200, "Explosive", "Standard"),
    
    # FIX 3: Updated to use X6s here as well
    Player_Badge = ifelse(X6s >= 5, "Power Hitter", "Technical Batter")
  )

print("--- Method B: Logic Results (Labels) ---")
print(head(df_logic %>% select(Player, Strike_Rate, Inning_Type, Player_Badge)))

#==============================================================================
# 4. METHOD C: TEXT TRANSFORMATION (paste)
#==============================================================================
# Scenario: Create a short sentence summary for a news report.
# Format: "[Player] scored [Runs] against [Against]"

df_text <- df_clean %>%
  mutate(
    Match_Summary = paste(Player, "scored", Runs, "runs against", Against)
  )

print("--- Method C: Text Transformation ---")
print(head(df_text$Match_Summary))

#==============================================================================
# 5. ALL TOGETHER (The Standard Workflow)
#==============================================================================

final_dataset <- df_clean %>%
  mutate(
    Strike_Rate = round((Runs / BF) * 100, 2),
    Is_High_Performance = ifelse(Runs > 70, TRUE, FALSE),
    Report = paste0(Player, " (SR: ", round((Runs/BF)*100, 1), ")")
  )

print("--- Final Combined Dataset ---")
print(head(final_dataset %>% select(Player, Report, Is_High_Performance)))
