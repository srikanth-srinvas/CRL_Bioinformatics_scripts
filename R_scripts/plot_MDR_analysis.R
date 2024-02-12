# Load required libraries
library(ggplot2)
library(tidyverse)

# Example data: Replace these with your actual data
pathogen_names <- c("E. faecium", "S. aureus", "K. pneumoniae", "A. baumannii", "P. aeruginosa", "Enterobacter spp")
total_counts <- c(16661, 147921, 88712, 38036, 94460, 48041)
mdr_counts <- c(5710, 1596, 27327, 23077, 17165, 7549)

# Combine vectors into a data frame
mdr_data <- data.frame(pathogen = pathogen_names, total_count = total_counts, mdr_count = mdr_counts)

# Calculate the proportion of MDR isolates relative to total isolates
mdr_data$mdr_proportion <- mdr_data$mdr_count / mdr_data$total_count

# Create the grouped bar plot
ggplot(mdr_data, aes(x = pathogen)) +
  geom_bar(aes(y = total_count, fill = "Total"), stat = "identity", position = "dodge") +
  geom_bar(aes(y = mdr_count, fill = "MDR"), stat = "identity", position = "dodge") +
  labs(title = "MDR Isolate Count Among Total Isolates for ESKAPE Pathogens",
       x = "Pathogen",
       y = "Count",
       fill = "Isolate Type") +
  scale_fill_manual(values = c("Total" = "gray", "MDR" = "blue")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.title = element_blank())
