import os
import re

def parse_busco_summary(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    species_name = os.path.basename(file_path).replace('short_summary.specific.enterobacterales_odb10.', '').replace('.txt', '')
    
    # Use regular expression to extract the percentage from the line
    percentage_line = next(line for line in lines if 'C:' in line)
    complete_percentage = float(re.search(r'C:(\d+\.\d+)%', percentage_line).group(1))

    return [species_name, complete_percentage]

def main():
    busco_directory = "/data/internship_data/srikanth_kpn/cgps_assembly_evaluation/ABA/dragonflye_out_1/busco_summaries"  # Replace with the actual path
    output_csv = "/data/internship_data/srikanth_kpn/cgps_assembly_evaluation/ABA/dragonflye_out_1/busco_summaries/output.csv"  # Replace with the desired output path

    # Get a list of all BUSCO summary files
    busco_files = [os.path.join(busco_directory, file) for file in os.listdir(busco_directory) if file.endswith(".txt")]

    # Parse each BUSCO summary file
    data = [parse_busco_summary(file) for file in busco_files]

    # Write the summary data to a CSV file
    with open(output_csv, 'w') as csv_file:
        csv_file.write("Species,Complete_Percentage\n")
        for species, percentage in data:
            csv_file.write(f"{species},{percentage}\n")

if __name__ == "__main__":
    main()
