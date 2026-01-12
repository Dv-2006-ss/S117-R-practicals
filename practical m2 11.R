# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)

# ---------------------------------------------------------
# 1. Load Data
# ---------------------------------------------------------
data <- read_csv(file.choose())
head(data)
# Rename columns for easy access
colnames(data) <- c(
  "Timestamp", "Gender", "Age", "Course", "Year_of_Study",
  "CGPA", "Marital_Status", "Depression", "Anxiety",
  "Panic_Attack", "Treatment"
)

# Remove rows with missing Age values
data_clean <- data %>% filter(!is.na(Age))

# ---------------------------------------------------------
# Plot 1: Histogram of Age
# ---------------------------------------------------------
ggplot(data_clean, aes(x = Age)) +
  geom_histogram(
    binwidth = 1,
    fill = "#69b3a2",
    color = "#e9ecef",
    alpha = 0.9
  ) +
  geom_density(aes(y = ..count..), color = "darkblue", size = 1) +
  theme_minimal() +
  labs(
    title = "Distribution of Student Age",
    subtitle = "Frequency of students by age group",
    x = "Age",
    y = "Count of Students"
  )

# ---------------------------------------------------------
# Plot 2: Box Plot (Age by Gender)
# ---------------------------------------------------------
ggplot(data_clean, aes(x = Gender, y = Age, fill = Gender)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 1) +
  scale_fill_manual(values = c("Female" = "#ffb7b2", "Male" = "#a2c2e0")) +
  theme_light() +
  labs(
    title = "Age Distribution by Gender",
    subtitle = "Comparison of age ranges between Male and Female students",
    x = "Gender",
    y = "Age"
  ) +
  theme(legend.position = "none")

# ---------------------------------------------------------
# Plot 3: Box Plot (Age by Depression Status)
# ---------------------------------------------------------
ggplot(data_clean, aes(x = Depression, y = Age, fill = Depression)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Pastel1") +
  theme_minimal() +
  labs(
    title = "Age vs Depression Status",
    x = "Do you have Depression?",
    y = "Age"
  )
