# Load required libraries
library(readr)

# Step 1: Read data from CSV file
data <- read_csv("/home/srikanth/Kpn_data/Kpn_1072 - specimen.csv")  # Replace "your_file.csv" with the actual file path

# Step 2: List of K and O types for testing
k_types_of_interest <- c("KL64", "KL51","KL2","KL10")  # Add more as needed
o_types_of_interest <- c("O1/O2v1", "O1/O2v2", "OL101")  # Add more as needed

# Step 3: Perform Fisher's exact tests
for (k_locus in k_types_of_interest) {
  contingency_table_k <- table(data$Disease, data$K_locus == k_locus)
  fisher_result_k <- fisher.test(contingency_table_k)
  
  p_value_k <- fisher_result_k$p.value
  
  # Print or store the results
  cat("Fisher's exact test for K-type", k_locus, ":", "\n")
  cat("P-value:", p_value_k, "\n\n")
}

for (o_locus in o_types_of_interest) {
  contingency_table_o <- table(data$Disease, data$O_locus == o_locus)
  fisher_result_o <- fisher.test(contingency_table_o)
  
  p_value_o <- fisher_result_o$p.value
  
  # Print or store the results
  cat("Fisher's exact test for O-type", o_locus, ":", "\n")
  cat("P-value:", p_value_o, "\n\n")
}
