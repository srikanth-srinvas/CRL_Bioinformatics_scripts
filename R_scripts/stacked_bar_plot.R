# Install and load the necessary packages if not already installed
# install.packages(c("ggplot2", "dplyr"))
library(ggplot2)
library(dplyr)

# Read data from CSV file
data <- read.csv("~/Kpn_data/K_locus_stacked.csv")

# Use specific totals for Invasive and Non-Invasive
total_invasive <- 499
total_non_invasive <- 573

# Calculate the percentage for each K_locus within Invasive and NonInvasive
data$Invasive_Percent <- (data$Invasive / total_invasive) * 100
data$Non.Insvasive_Percent <- (data$Non.Insvasive / total_non_invasive) * 100

# Reshape data for plotting
data_long <- gather(data, key = "Category", value = "Percent", Invasive_Percent, Non.Insvasive_Percent)

# Create a data frame to map K_locus to color
color_mapping <- data.frame(K_locus = data$K_locus, color = data$colour)

# Merge the color information into the data_long data frame
data_long <- merge(data_long, color_mapping, by = "K_locus")

# Set manual adjustments for width and position
bar_width <- 0.3  # Adjust as needed
position_adjustment <- 0.5  # Adjust as needed

# Sort data_long by Percent in descending order
data_long <- arrange(data_long, desc(Percent))

ggplot(data_long, aes(x = Percent, y = Category, fill = factor(K_locus), color = factor(K_locus))) +
  geom_bar(stat = "identity", position = position_stack(vjust = position_adjustment), width = bar_width) +
  labs(title = "Horizontally Stacked Bar Plot",
       x = "Percentage",
       y = NULL) +
  scale_x_continuous(labels = scales::percent_format()) +
  scale_fill_manual(values = data_long$color) +
  scale_color_manual(values = data_long$color) +
  theme_minimal()





