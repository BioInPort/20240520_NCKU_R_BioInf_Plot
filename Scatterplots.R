## Ref: https://ggplot2.tidyverse.org/reference/geom_point.html

#### Presetting ####
rm(list = ls()) # Clean variable ##* Comment out if Run All
# memory.limit(150000)


#### Load packages ####
if(!require("ggplot2")) install.packages("ggplot2"); library(ggplot2)


#### Load Data ####
# data_csv <- read.csv("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240517/20240517191837_data.csv")
# data_tsv <- read.table("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240517/20240517191837_data.tsv", sep = "\t", header = TRUE)
data <- read.csv("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240517/20240517191837_data.csv")

Set_X_Col <- "GeneA"
Set_Y_Col <- "GeneB"

#### Visualization ####
p <- ggplot(data, aes_string(x= Set_X_Col, y= Set_Y_Col)) + # p <- ggplot(data, aes(x= GeneA, y= GeneB)) +
  geom_point() +
  stat_summary(fun.data=mean_sdl, fun.args = list(mult=1), geom="errorbar", color="red")
print(p)

#### Export ####
## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Export_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## Export PDF
pdf(file = paste0(output_dir,"/",Name_time_wo_micro,"_Scatterplots.pdf"), width = 7,  height = 7)

print(p)

dev.off()

## Export TIFF
tiff(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplots.tiff"), width = 7, height = 7, units = "in", res = 300)

print(p)

dev.off()

## Export JPG
jpeg(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplots.jpg"), width = 7, height = 7, units = "in", res = 300)

print(p)

dev.off()





