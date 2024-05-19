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

set.seed(123)  # 设置随机数种子以保证结果可重复

# 生成Class a的数据，两个基因间无相关性
data_a <- data.frame(
  SampleID = paste("Sample", 1:20, sep=""),
  Gene1 = rnorm(20, mean=1.5, sd=0.5),
  Gene2 = rnorm(20, mean=1.5, sd=0.5),
  Class = "a"
)

# 生成Class b的数据，两个基因间呈正相关
mean_b <- 1.5
std_b <- 0.5
cor_b <- 0.9  # 设置较高的相关系数
cov_b <- std_b^2 * cor_b
Sigma_b <- matrix(c(std_b^2, cov_b, cov_b, std_b^2), ncol=2)
data_b <- MASS::mvrnorm(20, mu=c(mean_b, mean_b), Sigma=Sigma_b, empirical=TRUE)
data_b <- data.frame(
  SampleID = paste("Sample", 21:40, sep=""),
  Gene1 = data_b[,1],
  Gene2 = data_b[,2],
  Class = "b"
)

# 生成Class c的数据，两个基因间呈负相关
cor_c <- -0.6  # 设置较高的负相关系数
cov_c <- std_b^2 * cor_c
Sigma_c <- matrix(c(std_b^2, cov_c, cov_c, std_b^2), ncol=2)
data_c <- MASS::mvrnorm(20, mu=c(mean_b, mean_b), Sigma=Sigma_c, empirical=TRUE)
data_c <- data.frame(
  SampleID = paste("Sample", 41:60, sep=""),
  Gene1 = data_c[,1],
  Gene2 = data_c[,2],
  Class = "c"
)


# 合并所有数据
data <- rbind(data_a, data_b, data_c)


## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Demo_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## CSV
write.csv(data[,1:3], file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Scatterplot_Pattern.csv"), row.names = FALSE)

## TSV
write.table(data[,c(1,4)], file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Scatterplot_Pattern_Annot.tsv"), sep = "\t", row.names = FALSE)





