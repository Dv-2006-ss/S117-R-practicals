install.packages(c("readr", "psych"))

library(readr)    # For efficient data reading
library(psych)    # For descriptive statistics

my_data <- read.csv("CL_in_15_minute_new.csv")

# View the first few rows
head(CL_in_15_minute_new)

# View the last few rows
tail(CL_in_15_minute_new)

# Get the dimensions (rows and columns)
dim(CL_in_15_minute_new)

# Get the dimensions (rows and columns)
cat("Dimensions (Rows, Columns): ", dim(CL_in_15_minute_new), "\n")

# Get the structure (variable types and number of observations)
str(CL_in_15_minute_new)


# See a summary of the dataset
summaryCL_in_15_minute_new)

# Get the column names
names(CL_in_15_minute_new)
cat("Column Names: ", names(CL_in_15_minute_new), "\n")

# Use the 'psych' package for more detailed descriptive statistics
# 'describe()' provides: n, mean, sd, median, trimmed mean, mad, min, max, range, skew, kurtosis, and se.
describe(CL_in_15_minute_new)