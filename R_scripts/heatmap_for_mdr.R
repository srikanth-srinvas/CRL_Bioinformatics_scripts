# Example data: Replace these with your actual data
organism_names <- c("E. faecium ", "S. aureus", "K. pneumoniae", "A. baumanii", "P. aeruginosa","Enterobacter spp")
mdr_counts <- c(5710,1596, 27327,23077,17165,7549)
xdr_counts <- c(0, 0, 0, 0, 1601, 0)
total_organisms <- c(16661, 147921, 88712, 38036, 94460, 48041)

# Combine vectors into a data frame
mdr_xdr_data <- data.frame(organism = organism_names, mdr_count = mdr_counts, xdr_count = xdr_counts, total_organisms = total_organisms)

# Calculate the proportion of MDR isolates relative to total organisms
mdr_xdr_data$mdr_proportion <- mdr_xdr_data$mdr_count / mdr_xdr_data$total_organisms

# Load required libraries
library(ggplot2)

# Reshape data for heatmap
mdr_xdr_data_long <- mdr_xdr_data %>%
  pivot_longer(cols = c(mdr_proportion, xdr_count), names_to = "resistance_type", values_to = "value")

# Create the heatmap
ggplot(mdr_xdr_data_long, aes(x = 1, y = organism, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") + # Adjust the colors as needed
  labs(title = "MDR Isolates Coverage Among Total Organisms in ESKAPE Pathogens",
       x = "",
       y = "Organism",
       fill = "Coverage") +
  facet_wrap(~ resistance_type, scales = "free", ncol = 1) +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())















organism_names <- c("E. faecium ", "S. aureus", "K. pneumoniae", "A. baumanii", "P. aeruginosa","Enterobacter spp")
mdr_counts <- c(5710,, 8, 12, 6)
xdr_counts <- c(2, 3, 1, 5, 4)
