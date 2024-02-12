plasmid <- read.csv("/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/all_fastas/plasmidfinder_out/combined_results.tsv", sep = "\t")
plasmid %<>% select(ID, Plasmid.Identity) %>%  dplyr::mutate(presence = ("yes")) %>% dplyr::distinct()
plasmid_sorted <- plasmid  %>% pivot_wider(names_from = "Plasmid.Identity", values_from = "presence", values_fill = "no")

write.csv (plasmid_sorted,"/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/all_fastas/plasmidfinder_out/plasmid_sorted.csv")
