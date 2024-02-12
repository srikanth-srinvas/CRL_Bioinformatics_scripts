# Load the necessary libraries
library(dplyr)
library(ggplot2)

# Read your dataset into a data frame (replace 'your_dataset.csv' with the actual filename or path)
df <- read.csv('/home/srikanth/Kpn_data/Kpn_1072 - Sheet1.csv')

# Exclude entries in K_type that start with "unknown"
df_filtered <- df %>%
  filter(!grepl("^unknown", O_type))

# Group data by Resistance Score and K Type and count the occurrences
grouped <- df_filtered %>%
  group_by(resistance_score, O_type) %>%
  summarise(Count = n()) %>%
  ungroup()

# Create a unique color palette for each K_type
unique_o_types <- unique(grouped$O_type)
color_palettes <- rainbow(length(unique_o_types))

# Create a mapping of K_type to color palette
color_mapping <- data.frame(O_type = unique_o_types, Color = color_palettes)

# Merge the color mapping with the grouped data
grouped <- left_join(grouped, color_mapping, by = "O_type")

# Plot the distribution using ggplot2 with a color legend
ggplot(grouped, aes(x = resistance_score, y = Count, fill = O_type)) +
  geom_bar(stat = "identity") +
  labs(x = "Resistance Score", y = "Count", title = "Distribution of O Types for Each Resistance Score") +
  theme_minimal() +
  scale_fill_manual(values = color_mapping$Color, name = "O Type")
