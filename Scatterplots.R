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

#### Correlation ####
correlation <- cor.test(data[[Set_X_Col]], data[[Set_Y_Col]])
# correlation <- cor.test(data[[Set_X_Col]], data[[Set_Y_Col]], method="spearman")
r_value <- round(correlation$estimate, 2)
p_value <- format.pval(correlation$p.value, digits=2)

#### Visualization ####
## Basic plot
plot_scatter_Basic <- ggplot(data, aes_string(x= Set_X_Col, y= Set_Y_Col)) +
  geom_point()
print(plot_scatter_Basic)

## Add R value and P-Value
plot_scatter_cor <- plot_scatter_Basic +
  geom_smooth(method="lm", se=TRUE, linetype="dashed", color="#0066CC") +
  annotate("text", x = -Inf, y = Inf, label = paste("R =", r_value, "\nP =", p_value), hjust = -0.2, vjust = 1.3, size = 5, color = "#7B7B7B")
print(plot_scatter_cor)

## Beautify Plot
plot_scatter <- plot_scatter_cor +
  ggtitle("Scatter Plot") +
  theme_bw() +  # 白底
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 16),
    panel.border = element_rect(color = "black", linewidth = 1.5),  # 黑色粗外框
    aspect.ratio = 1  # 保持图形为正方形
  ) # + coord_fixed(ratio = 1)  # 保持图形为正方形

print(plot_scatter)

#### Export ####
## Set Expot ##
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
output_dir <- paste0(getwd(), "/Export_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)}


## Export PDF
pdf(file = paste0(output_dir,"/",Name_time_wo_micro,"_Scatterplots.pdf"), width = 7,  height = 7)

print(plot_scatter_Basic)
print(plot_scatter_cor)
print(plot_scatter)

dev.off()

## Export TIFF
tiff(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplots.tiff"), width = 7, height = 7, units = "in", res = 300)

print(plot_scatter)

dev.off()

## Export JPG
jpeg(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplots.jpg"), width = 7, height = 7, units = "in", res = 300)

print(plot_scatter)

dev.off()





