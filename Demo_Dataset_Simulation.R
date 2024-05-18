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

colnames(data) <- c("GeneA","GeneB")

#### Export ####
## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Demo_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## CSV
write.csv(data, file = paste0(output_dir, "/", Name_time_wo_micro, "_data.csv"), row.names = FALSE)

## TSV
write.table(data, file = paste0(output_dir, "/", Name_time_wo_micro, "_data.tsv"), sep = "\t", row.names = FALSE)


####*************************************************************************####
## Heatmap
#### Create data ####
## Basic Heatmap
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
write.csv(mat, file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Heatmap.csv"), row.names = TRUE)

## TSV
write.table(data.frame(SamppleID= row.names(annotation_row) ,annotation_row), file = paste0(output_dir, "/", Name_time_wo_micro, "_data_Heatmap_Annot.tsv"), sep = "\t", row.names = FALSE)


