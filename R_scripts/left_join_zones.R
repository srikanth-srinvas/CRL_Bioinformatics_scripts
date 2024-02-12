# Load the dplyr library if not already loaded
library(dplyr)

# Read the CSV files into data frames
states_data <- read.csv("/home/srikanth/Kpn_data/Kpn_1072 - states.csv")
zones_data <- read.csv("/home/srikanth/Kpn_data/Kpn_1072 - Zone_Master.csv")

# Perform a left join to assign zones based on the common column "State"
result_data <- states_data %>%
  left_join(zones_data, by = c("Region.Province.Department" = "State"))

# View the resulting data frame with zones assigned
View(result_data)
# Assuming your data frame is named 'result_data'
result_data$Zone <- ifelse(is.na(result_data$Zone), "Southern", result_data$Zone)

# Save the result_data as a CSV file
write.csv(result_data, file = "/home/srikanth/Kpn_data/merged_zones.csv", row.names = FALSE)
