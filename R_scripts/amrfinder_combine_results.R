library(dplyr)
library(magrittr)
library(tidyr)
library(readr)

# Import the amrfinder_hamronoze_summarydata
amrfinder_data <- readr::read_tsv('/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/all_fastas/amrfinder_out/amrfinder_combined.tsv')

# Summarize genes in a single column with comma-separated-values for each class (ex: blaNDM-1,blaOXA-23)
amrfinder_data_0 <- amrfinder_data %>% dplyr::distinct()
amrfinder_data_1 <- amrfinder_data_0 %>% select(`input_file_name`, `gene_symbol`, `drug_class`)
amrfinder_data_2 <- amrfinder_data_1 %>% dplyr::group_by(input_file_name, drug_class) %>% dplyr::summarise(`gene_symbol` = paste0(`gene_symbol`, collapse = ','))
amrfinder_data_3 <- amrfinder_data_2 %>% pivot_wider(names_from = 'drug_class', values_from = `gene_symbol`)

# Add yes/no for each gene presence and absence
amrfinder_data_4 <- amrfinder_data_1 %>% select(`input_file_name`, `gene_symbol`) %>% dplyr::mutate(presence = ("yes")) %>% dplyr::distinct()
amrfinder_data_5 <- amrfinder_data_4 %>% pivot_wider(names_from = "gene_symbol", values_from = "presence", values_fill = "no")
amrfinder_data_5 %<>% select(order(colnames(amrfinder_data_5))) %>% select(input_file_name, everything())

# Add R/S for each antibiotic class
amrfinder_data_6 <- amrfinder_data_1 %>% select(`input_file_name`, `drug_class`) %>% dplyr::mutate(presence = ("R")) %>% dplyr::distinct()
amrfinder_data_7 <- amrfinder_data_6 %>% dplyr::mutate_at(vars(contains("drug_class")), ~ paste0(.x, "_Insilico"))
amrfinder_data_7 %<>% pivot_wider(names_from = "drug_class", values_from = "presence", values_fill = "S")
amrfinder_data_7 %<>% select(order(colnames(amrfinder_data_7))) %>% select(input_file_name, everything())

# Combine all the data together
combined_data <- amrfinder_data_7 %>% dplyr::left_join(amrfinder_data_3, by = "input_file_name") %>% dplyr::left_join(amrfinder_data_5, by = "input_file_name")

# Write the CSV file
readr::write_csv(combined_data, "/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/all_fastas/amrfinder_out/amr_drug_class_data.csv")

