# Load required library
library(dplyr)

# Read the CSV file
df <- read.csv(file.choose(), stringsAsFactors = TRUE)

# View data
head(df)

# ---------------------------------------------
# Create required categorical variables
# ---------------------------------------------

# Price movement: Up / Down
df$Price_Movement <- ifelse(df$close > df$open, "Up", "Down")

# Volume category: High / Low
df$Volume_Group <- ifelse(df$volume > median(df$volume),
                          "High Volume", "Low Volume")

# ---------------------------------------------
# Cross-tabulation using table()
# ---------------------------------------------

print("Cross-Tabulation: Price Movement vs Volume Group")
print(table(df$Price_Movement, df$Volume_Group))

# Cross-tabulation with totals
print("Cross-Tabulation with Row & Column Totals")
print(addmargins(table(df$Price_Movement, df$Volume_Group)))

