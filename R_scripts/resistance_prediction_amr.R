# Load the necessary libraries
library(dplyr)
library(ggplot2)
library(AMR)

# Read the CSV file into a data frame (replace "your_file_path.csv" with the actual file path)
data <- read.csv("/home/srikanth/KPN-1072_PhD_Kleborate - MR_raw.csv")

# Convert "Year" column to date format
data$Year <- as.Date(paste(data$Year, "-01-01", sep = ""))

# Apply resistance_predict function
data %>%
  resistance_predict(
    col_date = "Year",
    col_ab = "BLEOMYCIN_Insilico.x",
    model = "binomial"
  )
predict_ble <- data %>%
  resistance_predict(
    col_date = "Year",
    col_ab = "BLEOMYCIN_Insilico.x",
    model = "binomial"
  )
plot(predict_ble)
ggplot_sir_predict(predict_ble)
