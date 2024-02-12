# Replace 'your_data.csv' with the path to your CSV file
file_path <- '~/Kpn_data/Kpn_1072 - Age.csv'

# Load the dplyr package for data manipulation
library(dplyr)

# Read data from CSV file
your_data <- read.csv(file_path)

# Group the data by 'Age' and calculate the Simpson's Diversity Index for each group
diversity_by_age_K <- your_data %>%
  group_by(age) %>%
  summarize(
    Simpson_Diversity_Index = 1 - sum((table(O_locus) / sum(table(O_locus)))^2)
  )

# View the resulting data frame
print(diversity_by_age_K)
