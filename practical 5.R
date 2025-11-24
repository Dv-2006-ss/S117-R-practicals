install.packages("dplyr")

library(dplyr)
library(readr) # For efficient reading

CL_in_15_minute_new <- read_csv("CL_in_15_minute_new.csv")

# Quick look at the data structure
head(CL_in_15_minute_new)

#The subset() function is a simple way to filter rows in base R (no extra packages needed).

#Example 1: Single Condition
#Filter for all houses where the median value (medv) is greater than $40,000 (where 1 unit = $1,000).

# Filter for houses with median value > 40
CL_in_15_minute_new <- subset(CL_in_15_minute_new,  medv > 40)

# Check the number of rows selected and the summary of the medv column
cat("Number of high-value houses (medv > 40):", nrow(CL_in_15_minute_new), "\n")
summary(CL_in_15_minute_new$medv)

#Example 2: Multiple Conditions (AND)
#Filter for houses where the median value (medv) is greater than $40,000 AND the crime rate (crim) is less than 0.1.

# Use the '&' (AND) operator to combine conditions
CL_in_15_minute_new <- subset(CL_in_15_minute_new, medv > 40 & crim < 0.1)

cat("Number of low-crime, high-value houses:", nrow(CL_in_15_minute_new), "\n")
head(CL_in_15_minute_new)

#Example 3: Multiple Conditions (OR)
#Filter for houses that are either near the Charles River (chas == 1) OR have a high average number of rooms (rm > 7.5).

# Use the '|' (OR) operator to combine conditions
CL_in_15_minute_new <- subset(CL_in_15_minute_new, chas == 1 | rm > 7.5)

cat("Number of special houses:", nrow(CL_in_15_minute_new), "\n")
head(CL_in_15_minute_new)

#Method 2: Using filter() (Tidyverse/dplyr)
#The filter() function from the dplyr package is generally preferred in modern R programming due to its speed, readability, and compatibility with the pipe operator (|>).

#Example 1: Single Condition (Using Pipe Operator)
#Filter for areas with a pupil-teacher ratio (ptratio) less than 14.

CL_in_15_minute_new <- CL_in_15_minute_new |>
  filter(ptratio < 14)

cat("Number of areas with low pupil-teacher ratio (< 14):", nrow(CL_in_15_minute_new), "\n")
summary(CL_in_15_minute_new$ptratio)

#Example 2: Multiple Conditions (Comma-Separated/AND)
#Filter for houses that are not near the Charles River (chas == 0) AND have a high percentage of lower status population (lstat > 25).

#In dplyr::filter(), using a comma between conditions is equivalent to the AND (&) operator.
# Comma-separated conditions = AND
CL_in_15_minute_new <- CL_in_15_minute_new |>
  filter(chas == 0, lstat > 25)

cat("Number of houses with high LSTAT, not near river:", nrow(CL_in_15_minute_new), "\n")
head(CL_in_15_minute_new)

#Example 3: Checking for Values in a Set (%in%)
#Filter for areas where the index of accessibility to radial highways (rad) is either 4 or 5.

# Use the %in% operator to check if a value is present in a vector
CL_in_15_minute_new <- CL_in_15_minute_new |>
  filter(rad %in% c(4, 5))

cat("Number of areas with RAD index 4 or 5:", nrow(CL_in_15_minute_new), "\n")
table(CL_in_15_minute_new$rad)
