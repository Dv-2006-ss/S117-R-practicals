chi_data <- read.csv(file.choose(), header = TRUE)

chi_data$Study_Habit <- factor(chi_data$Study_Habit)
chi_data$Exam_Result <- factor(chi_data$Exam_Result)

table_study_exam <- table(chi_data$Study_Habit, chi_data$Exam_Result)

chisq.test(table_study_exam)
