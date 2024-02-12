# Load the necessary libraries
library(dplyr)
library(ggplot2)
library(AMR)

# Read the CSV file into a data frame (replace "your_file_path.csv" with the actual file path)
data <- read.csv("/home/srikanth/KPN-1072_PhD_Kleborate - MR_raw.csv")

data %>%
  resistance_predict(
    col_date = "Year",
    col_ab = "AMINOGLYCOSIDE_Insilico",
    model = "binomial"
  )
predict_AMI <- data %>%
  resistance_predict(
    col_date = "Year",
    col_ab = "AMINOGLYCOSIDE_Insilico",
    model = "binomial"
  )
plot(predict_AMI)
ggplot_sir_predict(predict_AMI)

