# Read file 1
file1 <- read.csv("/data/internship_data/srikanth_kpn/fp_kpn/metadata/KPN_FP_AST_AMR - AST.csv")

# Read file 2
file2 <- read.csv("/data/internship_data/srikanth_kpn/fp_kpn/metadata/Antimicrobial Susceptibility Testing - Antimicrobial Susceptibility Testing.csv")

# Extract column headers from file 1
headers_file1 <- colnames(file1)

# Subset file 2 to include only columns present in file 1
file2_subset <- file2[, intersect(headers_file1, colnames(file2))]

# Merge based on common IDs
merged_data <- merge(file1, file2_subset, by = "ids", all.x = TRUE)

# Write the merged data to a new CSV file
write.csv(merged_data, "/data/internship_data/srikanth_kpn/fp_kpn/metadata/merged_ast.csv", row.names = FALSE)
