coffee2 <- read.csv(file.choose(), header = TRUE)

coffee2$Coffee_Type <- factor(coffee2$Coffee_Type)
coffee2$Work_Shift  <- factor(coffee2$Work_Shift)

anova_two_way <- aov(Productivity_Score ~ Coffee_Type * Work_Shift,
                     data = coffee2)

summary(anova_two_way)

names(coffee2)

