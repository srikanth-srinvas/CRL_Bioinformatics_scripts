raw_data <- read.csv("/home/srikanth/data_challenge/kpn_ris.csv")
# Assuming raw_data is your data frame
# Remove columns named "Amikacin", "Amoxycillin.clavulanate", and others
raw_data <- raw_data[, !(names(raw_data) %in% c("Amikacin", "Amoxycillin.clavulanate", "Ampicillin", "Azithromycin", "Cefepime", "Cefoxitin", "Ceftazidime", "Ceftriaxone", "Clarithromycin", "Clindamycin", "Erythromycin", "Imipenem", "Levofloxacin", "Linezolid", "Meropenem", "Metronidazole", "Minocycline", "Penicillin","Piperacillin.tazobactam","Tigecycline","Vancomycin","Ampicillin.sulbactam","Aztreonam","Aztreonam.avibactam","Cefexime","Ceftaroline","Ceftaroline.avibactam"))]
