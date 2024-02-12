# Load required libraries
library(readr)

# Step 1: Read data from CSV file
data <- read_csv("/home/srikanth/Kpn_data/carbapenem_genes_O.csv")  # Replace "your_file.csv" with the actual file path

# Step 2: Get unique elements in the K_locus column
unique_o_locus <- unique(data$O_locus)

# Create an empty data frame to store results
results <- data.frame(O_locus = character(), P_value = numeric())

# Step 3: Perform Fisher's exact tests for each unique K_locus
for (o_locus in unique_o_locus) {
  contingency_table_o <- table(data$carbapenem, data$O_locus == o_locus)
  fisher_result_o <- fisher.test(contingency_table_o, simulate.p.value = TRUE)
  
  p_value_o <- fisher_result_o$p.value
  
  # Store the results in the data frame
  results <- rbind(results, data.frame(O_locus = o_locus, P_value = p_value_o))
}

print(results)


# Write the results to a CSV file
write.csv(results, file = "~/Kpn_data/fishers_carb_O_loci_results.csv", row.names = FALSE)
