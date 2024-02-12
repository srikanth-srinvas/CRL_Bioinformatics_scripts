# Load required libraries
library(readr)
library(ggplot2)
library(dplyr)

# Step 1: Read data from CSV file
data <- read_csv("/home/srikanth/Kpn_data/carb_genes_K.csv")

# Specify the list of K loci to include
k_loci_of_interest <- c("KL2", "KL52", "KL64", "KL51", "KL102", "KL62", "KL81", "KL154", "KL10", "KL17", "KL139", "KL36", "KL23", "KL48", "KL112", "KL1", "KL25", "KL115", "KL20", "Novel (KL81)", "KL30", "KL169", "KL47")

# Filter data for the specified K loci
filtered_data <- data %>% filter(K_locus %in% k_loci_of_interest)

# Step 2: Define a custom color palette with hex codes for each carbapenem gene
custom_palette <- c(
  "#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF", "#00FFFF", "#800000", "#008000", "#000080", "#808000", "#800080", "#008080", "#808080"
)

# Create a named vector to map carbapenem genes to colors
color_mapping <- setNames(custom_palette, unique(filtered_data$carbapenem))

# Step 3: Create a stacked bar plot with the custom color palette
ggplot(filtered_data, aes(x = K_locus, fill = carbapenem)) +
  geom_bar(position = "stack") +
  scale_fill_manual(values = color_mapping) +  # Apply the custom color mapping
  theme_minimal() +
  labs(title = "Association of Carbapenem genes with K locus",
       x = "K_locus",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
