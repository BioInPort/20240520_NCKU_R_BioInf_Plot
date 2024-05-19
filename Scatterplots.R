## [Cheatsheets] https://posit.co/resources/cheatsheets/
## Ref: https://ggplot2.tidyverse.org/reference/geom_point.html

#### Presetting ####
rm(list = ls()) # Clean variables to ensure a fresh environment
# memory.limit(150000) # Set memory limit, if needed


#### Load packages ####
if(!require("ggplot2")) install.packages("ggplot2"); library(ggplot2) # Install and load ggplot2 package


#### Load Data ####
## Load data from CSV file
# data_csv <- read.csv("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240519/20240519115056_data_Scatterplot_Basic.csv")
## Load data from TSV file
# data_tsv <- read.table("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240519/20240519115056_data_Scatterplot_Basic.tsv", sep = "\t", header = TRUE)

# Load data from CSV file
data <- read.csv("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240519/20240519115056_data_Scatterplot_Basic.csv")

# Define columns to be used for plotting
Set_X_Col <- "Gene1"
Set_Y_Col <- "Gene2"

#### Correlation ####
# Calculate correlation between the selected columns
correlation <- cor.test(data[[Set_X_Col]], data[[Set_Y_Col]])
# correlation <- cor.test(data[[Set_X_Col]], data[[Set_Y_Col]], method="spearman") # For Spearman correlation
r_value <- round(correlation$estimate, 2)
p_value <- format.pval(correlation$p.value, digits=2)

#### Visualization ####
## Create a basic scatter plot
plot_scatter_Basic <- ggplot(data, aes_string(x= Set_X_Col, y= Set_Y_Col)) +
  geom_point()
print(plot_scatter_Basic)

## Add regression line, R value, and P value to the plot
plot_scatter_cor <- plot_scatter_Basic +
  geom_smooth(method="lm", se=TRUE, linetype="dashed", color="#0066CC") +
  annotate("text", x = -Inf, y = Inf, label = paste("R =", r_value, "\nP =", p_value), hjust = -0.2, vjust = 1.3, size = 6, color = "#7B7B7B")
print(plot_scatter_cor)

## Beautify the plot by adding title, adjusting text size, and setting aspect ratio
plot_scatter <- plot_scatter_cor +
  ggtitle("Scatter Plot") +
  theme_bw() +  # White background
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 16),
    panel.border = element_rect(color = "black", linewidth = 1.5),  # Black thick border
    aspect.ratio = 1  # Ensure the plot is square
  ) # + coord_fixed(ratio = 1)  # Ensure the plot is square

print(plot_scatter)

#### Export ####
## Set Expot
# Generate a timestamp for the export
Name_time_wo_micro <- substr(gsub("[- :]", "", as.character(Sys.time())), 1, 14)
# Define the output directory
output_dir <- paste0(getwd(), "/Export_", substr(Name_time_wo_micro, 1, 8))
if (!dir.exists(output_dir)) {dir.create(output_dir)} # Create the directory if it doesn't exist

## Export the plots to a PDF file
pdf(file = paste0(output_dir,"/",Name_time_wo_micro,"_Scatterplots.pdf"), width = 5,  height = 5)

print(plot_scatter)
print(plot_scatter_Basic)
print(plot_scatter_cor)

dev.off()

## Export the beautified plot to a TIFF file
tiff(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplot.tiff"), width = 5, height = 5, units = "in", res = 300)

print(plot_scatter)

dev.off()

## Export the beautified plot to a JPG file
jpeg(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplot.jpg"), width = 5, height = 5, units = "in", res = 300)

print(plot_scatter)

dev.off()


