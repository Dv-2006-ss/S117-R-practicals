study <- read.csv(file.choose(), header = TRUE)

colnames(study) <- c("Age","Genre","Concentration_Score")

study$Genre <- factor(study$Genre)

anova_music <- aov(Concentration_Score ~ Genre, data = study)
summary(anova_music)


