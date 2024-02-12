# Load required libraries
library(dplyr)

# Read the raw data from CSV file
raw_data <- read.csv("/home/srikanth/data_challenge/new_eskape.csv")

# Function to replace "Resistant", "Susceptible", and "Intermediate" with "R", "S", and "I" respectively
replace_resistant_susceptible_intermediate <- function(x) {
  x <- gsub("Resistant", "R", x)
  x <- gsub("Susceptible", "S", x)
  gsub("Intermediate", "I", x)
}

# Automatically detect columns containing "Resistant", "Susceptible", and "Intermediate" and replace them
raw_data <- raw_data %>%
  mutate(across(where(is.character), replace_resistant_susceptible_intermediate))

# Save the updated data to a new CSV file if needed
write.csv(raw_data, "/home/srikanth/data_challenge/kpn_ris.csv", row.names = FALSE)

