# Read the CSV files into data frames
file1 <- read.csv("~/Kpn_data/pathogenwatch_metadata/left_join/ids.csv")
file2 <- read.csv("~/Kpn_data/pathogenwatch_metadata/left_join/mr_main.csv")

# Perform a left join on the common column (adjust column names as needed)
left_joined <- merge(file1, file2, by = "x", all.x = TRUE)

# Save the result to a new CSV file
write.csv(left_joined, "~/Kpn_data/pathogenwatch_metadata/left_join/left_joined.csv", row.names = FALSE)
