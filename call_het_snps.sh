#!/bin/bash

reference_fasta="/data/internship_data/srikanth_kpn/global_st147_fastqs/G20250986_Nanopore_Ref.fasta"
output_dir="/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/snp_phylogeny_output/2023/sorted_bams/het_snps/vcfs"
csv_output="/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/snp_phylogeny_output/2023/sorted_bams/het_snps/results.csv"

# Ensure the output directory exists
mkdir -p "$output_dir"

# Iterate over all .bam files in the directory
for bam_file in /data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/snp_phylogeny_output/2023/sorted_bams/*.sorted.bam; do
    # Get the ID from the file name
    id=$(basename "$bam_file" .sorted.bam)

    # Run bcftools mpileup and bcftools call
    bcftools mpileup -f "$reference_fasta" "$bam_file" | bcftools call -mv -O v -o "$output_dir/$id.vcf"

    # Run het_snp_count.py on the generated VCF file
    python3 het_snp_count.py 50 "$output_dir/$id.vcf" >> "$csv_output"
done

echo "Script completed successfully!"
