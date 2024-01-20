import csv
from Bio import SeqIO
import glob
import os
import textwrap

# Define important variables for directories containing fasta files and amrfinder results, the output directory and a list of gene names
fasta_dir = '/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/all_fastas/fastas'
amrfinder_results_dir = '/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/all_fastas/amrfinder_out/'
output_dir = '/data/internship_data/srikanth_kpn/global_st147_fastqs/new_fastqs/all_fastas/carbapenem_contigs'
gene_names = ['blaIMP-14','blaKPC-3', 'blaNDM-1','blaNDM-29','blaNDM-5','blaNDM-7','blaOXA-181','blaOXA-232','blaOXA-48','blaKPC-2','blaVIM-1','blaVIM-26','blaVIM-27','blaVIM-33']

# function to get the contig name from the amrfinder results if there is a match to a gene
def find_contig_from_amrfinder(gene_name, amrfinder_result_filepath):
    with open(amrfinder_result_filepath) as tsvfile:
        reader = csv.DictReader(tsvfile, delimiter="\t")
        for row in reader:
            if gene_name == row['Gene symbol']:
                return row['Contig id']
        return None

# function to get the contig sequence from a genome multi fasta file given the contig name
def extract_contig_from_fasta(contig_name, fasta_filepath):
    with open(fasta_filepath) as file_handle:
        for record in SeqIO.parse(file_handle, "fasta"):
            if contig_name == record.id:
                return(str(record.seq))
        raise ValueError(f"Contig {contig_name} was not found in {fasta_filepath}")

##### write out data structures #####
# write out sample_sequences file
def write_sample_sequences(output_dir, sample_sequences):
    if not os.path.exists(output_dir):
        raise ValueError(f"Output dir {output_dir} not found. Please create it")

    sample_dir = os.path.join(output_dir,'samples')
    if not os.path.exists(sample_dir):
        os.mkdir(sample_dir)
    
    for sample_id in sample_sequences:
        output_filepath = os.path.join(sample_dir, f"{sample_id}.fasta")
        with open(output_filepath, "w") as output:
            for gene_name in sample_sequences[sample_id]:
                formated_sequence = '\n'.join(textwrap.wrap(sample_sequences[sample_id][gene_name],80))
                output.write(f">{gene_name}\n{formated_sequence}\n")

# write out gene_sequence file
def write_gene_name_sequences(output_dir, gene_name_sequences) :
    if not os.path.exists(output_dir):
        raise ValueError(f"Output dir {output_dir} not found. Please create it")

    gene_dir = os.path.join(output_dir,'genes')
    if not os.path.exists(gene_dir):
        os.mkdir(gene_dir) 
    
    for gene_name in gene_name_sequences:
        output_filepath = os.path.join(gene_dir,f"{gene_name}.fasta")
        with open(output_filepath, "w") as output:
            for sample_id in gene_name_sequences[gene_name]:
                formated_sequence = '\n'.join(textwrap.wrap(gene_name_sequences[gene_name][sample_id],80))
                output.write(f">{sample_id}\n{formated_sequence}\n")

# initialise data structures. expected structure is shown

# gene_name_sequences = {
#   'blaNDM-1': {
#       'sample_id1': 'CGTAGCTAGCCAGTCGCA....',
#       'sample_id2': 'CGTAGCTAGCCAGTCGCA....',
#        .....
#    },
#    'blaNDM-7': {.....}
# }
gene_name_sequences = {}
# sample_sequences = {
#   'sample_id1': {
#       'blaNDM-1': 'CGTAGCTAGCCAGTCGCA....',
#       'blaNDM-7': 'CGTAGCTAGCCAGTCGCA....',
#        .....
#    },
#   'sample_id2': {....}
# }
sample_sequences = {}

# find files to parse
for report_file in glob.glob(os.path.join(amrfinder_results_dir, "*.tsv")):
    # get file id
    sample_id = os.path.basename(report_file).replace('.tsv', '')
    # create an entry for this sample in the sample_sequences directory
    if sample_id not in sample_sequences:
        sample_sequences[sample_id] = {}
    
    # define the path for the matching fasta file
    fasta_filepath = os.path.join(fasta_dir, f"{sample_id}.fasta")

    # loop through the genes
    for gene_name in gene_names:
        # create an entry for this gene in the gene_name_sequences directory
        if gene_name not in gene_name_sequences:
            gene_name_sequences[gene_name] = {}
        # get the contig name
        contig_name_with_gene = find_contig_from_amrfinder(gene_name, report_file)
        if contig_name_with_gene:
            # extract the contig sequence from the genome multi fasta file
            contig_sequence = extract_contig_from_fasta(contig_name_with_gene, fasta_filepath)
            # add this sequence to the two data structures
            gene_name_sequences[gene_name][sample_id] = contig_sequence
            sample_sequences[sample_id][gene_name] = contig_sequence


####### write out results #######
write_sample_sequences(output_dir, sample_sequences)
write_gene_name_sequences(output_dir, gene_name_sequences)




