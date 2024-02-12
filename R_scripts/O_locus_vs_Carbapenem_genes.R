# Load required libraries
library(readr)
library(ggplot2)
library(dplyr)

# Step 1: Read data from CSV file
data <- read_csv("/home/srikanth/Kpn_data/carbapenem_genes_O.csv")

# Step 2: Define a custom color palette with hex codes for each carbapenem gene
custom_palette <- c(
  "#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF", "#00FFFF", "#800000", "#008000", "#000080", "#808000", "#800080", "#008080", "#808080"
)

# Create a named vector to map carbapenem genes to colors
color_mapping <- setNames(custom_palette, unique(data$carbapenem))

# Step 3: Create a stacked bar plot with the custom color palette
ggplot(data, aes(x = O_locus, fill = carbapenem)) +
  geom_bar(position = "stack") +
  scale_fill_manual(values = color_mapping) +  # Apply the custom color mapping
  theme_minimal() +
  labs(title = "Association of Carbapenem genes with O locus",
       x = "O_locus",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
