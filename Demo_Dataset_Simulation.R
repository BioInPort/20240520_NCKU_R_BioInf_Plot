## [Cheatsheets] https://posit.co/resources/cheatsheets/

#### Presetting ####
rm(list = ls()) # Clean variable ##* Comment out if Run All
# memory.limit(150000)


#### Load packages ####
if(!require("tidyverse")) install.packages("tidyverse"); library(tidyverse)

####*************************************************************************####
## Scatterplots
#### Create data ####
## Basic scatterplots
set.seed(123)
data <- data.frame(
  x = rnorm(50),
  y = rnorm(50)
)

colnames(data) <- c("Gene1","Gene2")

#### Export ####
## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Demo_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## CSV
write.csv(data, file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Scatterplot_Basic.csv"), row.names = FALSE)

## TSV
write.table(data, file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Scatterplot_Basic.tsv"), sep = "\t", row.names = FALSE)


####*************************************************************************####
## Heatmap
#### Create data ####

#### Basic Simulation ####
set.seed(123)
mat <- matrix(rnorm(200), 20, 10)
rownames(mat) <- paste("Gene", 1:20, sep="")
colnames(mat) <- paste("Sample", 1:10, sep="")

# Create annotation data for rows
annotation_row <- data.frame(Class = sample(letters[1:3], 10, replace = TRUE))
rownames(annotation_row) <- colnames(mat)

#### Export ####
## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Demo_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## CSV
write.csv(mat, file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Heatmap_Basic.csv"), row.names = TRUE)

## TSV
write.table(data.frame(SamppleID= row.names(annotation_row) ,annotation_row), file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Heatmap_Basic_Annot.tsv"), sep = "\t", row.names = FALSE)


################################################################################
#### Pattern Simulation ####
rm(list = ls()) # Clean variable ##* Comment out if Run All
# Load required packages
if(!require("pheatmap")) install.packages("pheatmap"); library(pheatmap)

# Set seed for reproducibility
set.seed(123)

# Number of genes and samples
n_genes <- 20
n_samples_per_group <- 4
n_groups <- 3
n_samples <- n_samples_per_group * n_groups

# Create annotation data for columns (Samples)
group_labels <- rep(letters[1:n_groups], each = n_samples_per_group)
annotation_col <- data.frame(Class = factor(group_labels, levels = letters[1:n_groups]))
rownames(annotation_col) <- paste("Sample", 1:n_samples, sep="")

# Initialize matrix
mat <- matrix(nrow = n_genes, ncol = n_samples)
rownames(mat) <- paste("Gene", 1:n_genes, sep="")
colnames(mat) <- rownames(annotation_col)

# Generate data with different patterns for each sample class
for (i in 1:n_genes) {
  # Generate base values
  a_values <- runif(n_samples_per_group, min = 3, max = 7)
  b_values <- runif(n_samples_per_group, min = -7, max = -3)

  # Randomly decide the pattern for this gene
  pattern <- sample(c("high_a", "low_a", "neutral"), 1)

  if (pattern == "high_a") {
    a_values <- runif(n_samples_per_group, min = 3, max = 7)
    b_values <- runif(n_samples_per_group, min = -7, max = -3)
  } else if (pattern == "low_a") {
    a_values <- runif(n_samples_per_group, min = -7, max = -3)
    b_values <- runif(n_samples_per_group, min = 3, max = 7)
  } else {
    a_values <- runif(n_samples_per_group, min = 1, max = 3)
    b_values <- runif(n_samples_per_group, min = -3, max = -1)
  }

  c_values <- rnorm(n_samples_per_group, mean = 0, sd = 1.7)

  mat[i, annotation_col$Class == "a"] <- a_values
  mat[i, annotation_col$Class == "b"] <- b_values
  mat[i, annotation_col$Class == "c"] <- c_values
}

# Introduce outliers randomly, with absolute values less than ?
set.seed(456) # Different seed for outliers
outlier_indices <- sample(1:(n_genes * n_samples), 17) # Randomly select 11 points to be outliers
mat[outlier_indices] <- ifelse(mat[outlier_indices] > 0, mat[outlier_indices] + sample(1:3, 9, replace = TRUE),
                               mat[outlier_indices] - sample(1:3, 9, replace = TRUE))

# Create a basic heatmap
heatmap_basic <- pheatmap(mat)

# Beautify the heatmap
# Define colors for the annotation
annotation_colors <- list(Class = c("a" = "#4a6ac2", "b" = "#32a852", "c" = "#cc5a78"))
annotation_colors <- list(Class = c("a" = "#8958a3", "b" = "#4c9c6f", "c" = "#4b4b5c"))


# Create the heatmap
heatmap <- pheatmap(mat,
                    cluster_rows = TRUE,
                    cluster_cols = TRUE,
                    display_numbers = TRUE,
                    annotation_col = annotation_col,
                    annotation_colors = annotation_colors)


#### Export ####
## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Demo_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## CSV
write.csv(mat, file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Heatmap_Pattern.csv"), row.names = TRUE)

## TSV
write.table(data.frame(SampleID= row.names(annotation_col) ,annotation_col), file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Heatmap_Pattern_Annot.tsv"), sep = "\t", row.names = FALSE)


####*************************************************************************####
## Scatterplots
#### Pattern Simulation ####
rm(list = ls()) # Clean variable ##* Comment out if Run All
# Load required packages
if(!require("pheatmap")) install.packages("pheatmap"); library(pheatmap)

# Set seed for reproducibility
set.seed(123)

# Number of genes and samples
n_genes <- 20
n_samples_per_group <- 10
n_groups <- 3
n_samples <- n_samples_per_group * n_groups

# Create annotation data for columns (Samples)
group_labels <- rep(letters[1:n_groups], each = n_samples_per_group)
annotation_col <- data.frame(Class = factor(group_labels, levels = letters[1:n_groups]))
rownames(annotation_col) <- paste("Sample", 1:n_samples, sep="")

# Initialize matrix
mat <- matrix(nrow = n_genes, ncol = n_samples)
rownames(mat) <- paste("Gene", 1:n_genes, sep="")
colnames(mat) <- rownames(annotation_col)

# Generate data with different patterns for each sample class
for (i in 1:n_genes) {
  # Generate base values
  a_values <- runif(n_samples_per_group, min = 3, max = 7)
  b_values <- runif(n_samples_per_group, min = -7, max = -3)

  # Randomly decide the pattern for this gene
  pattern <- sample(c("high_a", "low_a", "neutral"), 1)

  if (pattern == "high_a") {
    a_values <- runif(n_samples_per_group, min = 3, max = 7)
    b_values <- runif(n_samples_per_group, min = -7, max = -3)
  } else if (pattern == "low_a") {
    a_values <- runif(n_samples_per_group, min = -7, max = -3)
    b_values <- runif(n_samples_per_group, min = 3, max = 7)
  } else {
    a_values <- runif(n_samples_per_group, min = 1, max = 3)
    b_values <- runif(n_samples_per_group, min = -3, max = -1)
  }

  c_values <- rnorm(n_samples_per_group, mean = 0, sd = 1.7)

  mat[i, annotation_col$Class == "a"] <- a_values
  mat[i, annotation_col$Class == "b"] <- b_values
  mat[i, annotation_col$Class == "c"] <- c_values
}

# Introduce outliers randomly, with absolute values less than ?
set.seed(456) # Different seed for outliers
outlier_indices <- sample(1:(n_genes * n_samples), 17) # Randomly select 11 points to be outliers
mat[outlier_indices] <- ifelse(mat[outlier_indices] > 0, mat[outlier_indices] + sample(1:3, 9, replace = TRUE),
                               mat[outlier_indices] - sample(1:3, 9, replace = TRUE))

# Create a basic heatmap
heatmap_basic <- pheatmap(mat)

# Beautify the heatmap
# Define colors for the annotation
annotation_colors <- list(Class = c("a" = "#4a6ac2", "b" = "#32a852", "c" = "#cc5a78"))
annotation_colors <- list(Class = c("a" = "#8958a3", "b" = "#4c9c6f", "c" = "#4b4b5c"))


# Create the heatmap
heatmap <- pheatmap(mat,
                    cluster_rows = TRUE,
                    cluster_cols = TRUE,
                    display_numbers = TRUE,
                    annotation_col = annotation_col,
                    annotation_colors = annotation_colors)

data <- mat[c("Gene5", "Gene8"), ] %>% t() %>% as.data.frame()

## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Demo_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## CSV
write.csv(data.frame(SampleID= row.names(data) ,data), file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Scatterplot_Pattern.csv"), row.names = FALSE)

## TSV
write.table(data.frame(SampleID= row.names(annotation_col) ,annotation_col), file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Scatterplot_Pattern_Annot.tsv"), sep = "\t", row.names = FALSE)





