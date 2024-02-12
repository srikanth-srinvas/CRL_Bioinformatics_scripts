# Install required packages if not already installed
if (!requireNamespace("ggtree", quietly = TRUE)) {
  install.packages("ggtree")
}

if (!requireNamespace("heatmaply", quietly = TRUE)) {
  install.packages("heatmaply")
}

# Load required libraries
library(ggtree)
library(heatmaply)

# Read the phylogenetic tree
tree <- read.tree("phylogenetic_tree.newick")

# Read the gene presence/absence matrix
matrix <- read.csv("gene_presence_absence.csv", row.names = 1)

# Combine tree and matrix data
combined_data <- data.frame(t(matrix), tree$tip.label)

# Create a phylogenetic tree plot using ggtree
tree_plot <- ggtree(tree, layout = "circular", aes(color = as.factor(tip.label)))

# Create a heatmap for the gene presence/absence matrix
heatmap_plot <- heatmaply(as.matrix(matrix), Colv = FALSE)

# Combine the plots
combined_plot <- tree_plot + ggplotify::as_ggplot(heatmap_plot)

# Display the combined plot
print(combined_plot)

