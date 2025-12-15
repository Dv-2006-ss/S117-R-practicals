# Load required library
library(dplyr)

# Read the CSV file
df <- read.csv(file.choose(), stringsAsFactors = TRUE)

# View data
head(df)

df$Volume_Group <- ifelse(df$volume > median(df$volume),
                          "High Volume", "Low Volume")

# ---------------------------------------------
# Independent two-sample t-test
# ---------------------------------------------
# Compare close prices between High and Low Volume groups

t_test_independent <- t.test(close ~ Volume_Group, data = df)
print(t_test_independent)
