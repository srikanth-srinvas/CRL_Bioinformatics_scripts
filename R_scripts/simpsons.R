# Assuming your data is in a data frame called 'your_data' with columns 'Region/Province/Department' and 'K_type'
# Replace 'your_data' with the actual name of your data frame

# Load the dplyr package for data manipulation
library(dplyr)

# Group the data by 'Region/Province/Department' and calculate the Simpson's Diversity Index for each group
diversity_by_region_K <- your_data %>%
  group_by(`Region.Province.Department`) %>%
  summarize(
    Simpson_Diversity_Index = 1 - sum((table(K_type) / sum(table(K_type)))^2)
  )

# View the resulting data frame
print(diversity_by_region_K)
# Load the ggplot2 package for data visualization
library(ggplot2)

# Assuming 'diversity_by_region' contains the results
# Ensure 'Simpson_Diversity_Index' is a numeric column in your data frame

# Create a bar plot
ggplot(diversity_by_region_K, aes(x = `Region.Province.Department`, y = Simpson_Diversity_Index)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Region.Province.Department", y = "Simpson's Diversity Index") +
  ggtitle("Simpson's Diversity Index by Region/Province/Department") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for readability
