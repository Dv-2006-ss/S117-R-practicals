# ---------------------------------------------------------
# Practical 10: Creating Graphical Reports using ggplot2 (R)
# ---------------------------------------------------------

# Load required libraries
library(ggplot2)
library(dplyr)
library(readr)

# ---------------------------------------------------------
# 1. Load Data
# ---------------------------------------------------------
data <- read_csv(file.choose())
head(data)

# Rename columns for easy use
colnames(data) <- c(
  "Timestamp", "Gender", "Age", "Course", "Year_of_Study",
  "CGPA", "Marital_Status", "Depression", "Anxiety",
  "Panic_Attack", "Treatment"
)

# Clean data
data_clean <- data %>% filter(!is.na(Age), !is.na(CGPA))

# =========================================================
# SCATTER PLOT: Age vs CGPA
# =========================================================
ggplot(data_clean, aes(x = Age, y = CGPA, color = Gender)) +
  geom_point(size = 3, alpha = 0.7) +
  theme_minimal() +
  labs(
    title = "Scatter Plot of Age vs CGPA",
    subtitle = "Relationship between student age and academic performance",
    x = "Age",
    y = "CGPA"
  )

# =========================================================
# PIE CHART: Depression Status Distribution
# =========================================================
depression_data <- data_clean %>%
  count(Depression)

ggplot(depression_data, aes(x = "", y = n, fill = Depression)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  theme_void() +
  labs(
    title = "Pie Chart of Depression Status Among Students",
    fill = "Depression"
  )

# =========================================================
# HIGH-LOW CHART: Age Range by Gender
# =========================================================
high_low_data <- data_clean %>%
  group_by(Gender) %>%
  summarise(
    Min_Age = min(Age),
    Max_Age = max(Age)
  )

ggplot(high_low_data, aes(x = Gender)) +
  geom_linerange(aes(ymin = Min_Age, ymax = Max_Age), size = 8, color = "#4c72b0") +
  geom_point(aes(y = Min_Age), color = "darkgreen", size = 4) +
  geom_point(aes(y = Max_Age), color = "darkred", size = 4) +
  theme_minimal() +
  labs(
    title = "High-Low Chart of Age by Gender",
    subtitle = "Minimum and Maximum age distribution",
    x = "Gender",
    y = "Age"
  )
 