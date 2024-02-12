o_data <- read.csv("/home/srikanth/Kpn_data/Kpn_1072 - diversity_index_o.csv")
library(dplyr)

# Group the data by 'Region/Province/Department' and calculate the Simpson's Diversity Index for each group
diversity_by_region_O <- o_data %>%
  group_by(`Region.Province.Department`) %>%
  summarize(
    Simpson_Diversity_Index = 1 - sum((table(O_type) / sum(table(O_type)))^2)
  )

# View the resulting data frame
print(diversity_by_region_O)