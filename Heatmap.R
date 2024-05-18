## [Cheatsheets] https://posit.co/resources/cheatsheets/
## Ref: https://ggplot2.tidyverse.org/reference/geom_point.html

#### Presetting ####
rm(list = ls()) # Clean variables to ensure a fresh environment
# memory.limit(150000) # Set memory limit, if needed


#### Load packages ####
# if(!require("tidyverse")) install.packages("tidyverse"); library(tidyverse) # Install and load tidyverse package


#### Load Data ####
## Load data from CSV file
# mat_CSV <- read.csv("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240518/20240518030902_data_Heatmap.csv", row.names = 1)
## Load data from TSV file
# mat_tsv <- read.table("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240518/20240518030902_data_Heatmap.tsv", sep = "\t", header = TRUE, row.names = 1)

# Load data from CSV file
mat <- read.csv("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240518/20240518030902_data_Heatmap.csv", row.names = 1)

# Define columns to be used for plotting
# Set_X_Col <- "GeneA"
# Set_Y_Col <- "GeneB"


if(!require("pheatmap")) install.packages("pheatmap"); library(pheatmap) # Install and load pheatmap package

## Create a basic heatmap
heatmap_basic <- pheatmap(mat)

## Beautify the heatmap
heatmap <- pheatmap(mat, cluster_rows=TRUE, cluster_cols=TRUE,
                    display_numbers=TRUE,
                    annotation_row=data.frame(Class=sample(letters[1:3], 20, replace=TRUE)),
                    annotation_colors=list(Class=c("a"="blue", "b"="green", "c"="red")))



#### Export ####
## Set Expot
# Generate a timestamp for the export
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
# Define the output directory
output_dir <- paste0(getwd(), "/Export_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)} # Create the directory if it doesn't exist

## Export the plots to a PDF file
pdf(file = paste0(output_dir,"/",Name_time_wo_micro,"_heatmap.pdf"), width = 7,  height = 7)

print(heatmap)

dev.off()

## Export the beautified plot to a TIFF file
tiff(file = paste0(output_dir, "/", Name_time_wo_micro, "_heatmap.tiff"), width = 7, height = 7, units = "in", res = 300)

print(heatmap)

dev.off()

## Export the beautified plot to a JPG file
jpeg(file = paste0(output_dir, "/", Name_time_wo_micro, "_heatmap.jpg"), width = 7, height = 7, units = "in", res = 300)

print(heatmap)

dev.off()


