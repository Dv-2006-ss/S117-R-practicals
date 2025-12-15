# Load required libraries
library(psych)
library(dplyr)

# Load CSV file
df <- read.csv(file.choose(), stringsAsFactors = TRUE)

# View dataset
head(df)

# ---------------------------------------------
# Create categorical variables
# ---------------------------------------------

# Price movement: Up / Down
df$Price_Movement <- ifelse(df$close > df$open, "Up", "Down")

# Volume category: High / Low (based on median)
df$Volume_Group <- ifelse(df$volume > median(df$volume),
                          "High Volume", "Low Volume")

# ---------------------------------------------
# Frequency tables using table()
# ---------------------------------------------

print("Frequency Table: Symbol")
print(table(df$symbol))

print("Frequency Table: Price Movement")
print(table(df$Price_Movement))

print("Frequency Table: Volume Group")
print(table(df$Volume_Group))

# Two-way frequency table
print("Two-way Frequency Table: Price Movement vs Volume Group")
print(table(df$Price_Movement, df$Volume_Group))

# ---------------------------------------------
# Frequency tables using dplyr::count()
# ---------------------------------------------

print("Count using dplyr::count - Symbol")
print(df %>% count(symbol))

print("Count using dplyr::count - Price Movement")
print(df %>% count(Price_Movement))

print("Count using dplyr::count - Volume Group")
print(df %>% count(Volume_Group))

