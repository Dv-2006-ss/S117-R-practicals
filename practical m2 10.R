# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

# 1. Load your CSV file
data <- read_csv(file.choose())
head(data)

# 2. Reshape data for multiple line plotting
financial_trend <- data %>%
  select(Year, Revenue, Net_Income) %>%
  pivot_longer(
    cols = c(Revenue, Net_Income),
    names_to = "Metric",
    values_to = "Amount"
  )

# 3. Create the Line Graph
ggplot(financial_trend, aes(x = Year, y = Amount, color = Metric, group = Metric)) +
  geom_line(size = 1.5) +
  geom_point(size = 4) +
  theme_minimal() +
  scale_color_manual(values = c(
    "Revenue" = "#3498db",
    "Net_Income" = "#e74c3c"
  )) +
  labs(
    title = "Financial Trend Analysis",
    subtitle = "Comparison of Revenue and Net Income Over Time",
    x = "Year",
    y = "Amount",
    color = "Financial Metric"
  ) +
  theme(legend.position = "bottom")
.
