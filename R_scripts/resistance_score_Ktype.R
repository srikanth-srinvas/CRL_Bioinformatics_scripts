# Load the necessary libraries
library(dplyr)
library(ggplot2)

# Read your dataset into a data frame (replace 'your_dataset.csv' with the actual filename or path)
df <- read.csv('/home/srikanth/Kpn_data/Kpn_1072 - Sheet1.csv')

# Exclude entries in K_type that start with "unknown"
df_filtered <- df %>%
  filter(!grepl("^unknown", K_type))

# Group data by Resistance Score and K Type and count the occurrences
grouped <- df_filtered %>%
  group_by(resistance_score, K_type) %>%
  summarise(Count = n()) %>%
  ungroup()

# Assign a color for each K_type
colors <- scale_fill_manual(values = scales::brewer_pal(palette = "Set3")(length(unique(grouped$K_type))))

# Plot the distribution using ggplot2
ggplot(grouped, aes(x = resistance_score, y = Count, fill = K_type)) +
  geom_bar(stat = "identity") +
  labs(x = "Resistance Score", y = "Count", title = "Distribution of K Types for Each Resistance Score") +
  theme_minimal() +
  colors
