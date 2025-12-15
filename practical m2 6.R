# Load required library
library(dplyr)

# Read the CSV file
df <- read.csv(file.choose(), stringsAsFactors = TRUE)

# View data
head(df)

t_test_paired <- t.test(df$open, df$close, paired = TRUE)
print(t_test_paired)
