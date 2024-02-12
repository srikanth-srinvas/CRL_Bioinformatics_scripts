# Load required libraries
library(readr)

# Read your raw data from a CSV file
raw_data <- read_csv("/home/srikanth/Kpn_data/Kpn_1072 - All_STs.csv")  # Replace with the actual file path

# List unique STs, K locus types, and O locus types
sts <- unique(raw_data$ST)
k_types <- unique(raw_data$K_locus)
o_types <- unique(raw_data$O_locus)

# Create a data frame to store the results
results_df <- data.frame(ST = character(), K_locus = character(), O_locus = character(), P_value = numeric(), stringsAsFactors = FALSE)

# Perform Fisher's exact test for each combination
# Perform Fisher's exact test for each combination
# Perform Fisher's exact test for each combination
# Perform Fisher's exact test for each combination
for (st in sts) {
  for (k_type in k_types) {
    for (o_type in o_types) {
      # Create a contingency table
      contingency_table <- table(raw_data$K_locus[raw_data$ST == st] == k_type, raw_data$O_locus[raw_data$ST == st] == o_type)
      
      # Check if there's enough variation in the data
      if (sum(contingency_table) > 1) {
        # Ensure the contingency table is a matrix
        if (is.matrix(contingency_table) && all(dim(contingency_table) >= 2)) {
          fisher_result <- fisher.test(contingency_table)
          p_value <- fisher_result$p.value
          
          # Append the results to the data frame
          results_df <- rbind(results_df, c(st, k_type, o_type, p_value))
        } else {
          cat("Invalid contingency table dimensions for ST =", st, ", K_type =", k_type, ", O_type =", o_type, "\n")
        }
      }
    }
  }
}


# Write results to a CSV file
write.csv(results_df, file = "/home/srikanth/Kpn_data/fishers_combined.csv", row.names = FALSE)
