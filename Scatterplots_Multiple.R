## [Cheatsheets] https://posit.co/resources/cheatsheets/
## Ref: https://ggplot2.tidyverse.org/reference/geom_point.html

#### Presetting ####
rm(list = ls()) # Clean variables to ensure a fresh environment
# memory.limit(150000) # Set memory limit, if needed


#### Load packages ####
if(!require("ggplot2")) install.packages("ggplot2"); library(ggplot2) # Install and load ggplot2 package
if(!require("dplyr")) install.packages("dplyr"); library(dplyr) # Install and load dplyr package
# if(!require("ggpubr")) install.packages("ggpubr"); library(ggpubr) # Install and load ggpubr for easy stats


#### Load Data ####
# Load expression data from CSV file
mat <- read.csv("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240519/20240519121913_data_Scatterplot_Pattern.csv", row.names = 1)
data <- data.frame(SampleID= row.names(mat), mat)

# Load meta data from CSV file
annotation_col <- read.table("D:/Dropbox/##_GitHub/##_BioInPort/20240520_NCKU_R_BioInf_Plot/Demo_20240519/20240519121913_data_Scatterplot_Pattern_Annot.tsv", sep = "\t", header = TRUE, row.names = 1)
annotation_col <- data.frame(SampleID= row.names(annotation_col) ,annotation_col)

data <- left_join(data, annotation_col, by = "SampleID")  # Ensure that 'SampleID' is the matching column in both data frames


# Define columns to be used for plotting
Set_X_Col <- "Gene1"
Set_Y_Col <- "Gene2"
Set_class <- "Class"

#### Correlation ####
# Calculate correlation for each class and add to the plot
unique_classes <- unique(data[[Set_class]])
text_labels <- data.frame(x = numeric(), y = numeric(), label = character())

for (class in unique_classes) {
  subset_data <- data[data[[Set_class]] == class, ]
  correlation <- cor.test(subset_data[[Set_X_Col]], subset_data[[Set_Y_Col]])
  r_value <- round(correlation$estimate, 2)
  p_value <- format.pval(correlation$p.value, digits = 2)
  max_x <- max(subset_data[[Set_X_Col]], na.rm = TRUE)
  max_y <- max(subset_data[[Set_Y_Col]], na.rm = TRUE)
  # Adjust the y position for text to be above the highest data point
  text_labels <- rbind(text_labels, data.frame(x = max_x, y = max_y * 1.05, label = sprintf("Class %s: R = %.2f; P = %s", class, r_value, p_value)))
}

#### Visualization ####
## Create a basic scatter plot
plot_scatter_Basic <- ggplot(data, aes(x = !!sym(Set_X_Col), y = !!sym(Set_Y_Col), color = !!sym(Set_class))) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, aes(color = !!sym(Set_class)))  # Add regression line with confidence interval for each group

## Prepare labels with their respective classes for correct color mapping
text_labels <- data.frame(x = numeric(), y = numeric(), label = character(), class = character())
for (class in unique_classes) {
  subset_data <- data[data[[Set_class]] == class, ]
  correlation <- cor.test(subset_data[[Set_X_Col]], subset_data[[Set_Y_Col]])
  r_value <- round(correlation$estimate, 2)
  p_value <- format.pval(correlation$p.value, digits = 2)
  max_x <- max(subset_data[[Set_X_Col]], na.rm = TRUE)
  max_y <- max(subset_data[[Set_Y_Col]], na.rm = TRUE)
  # Append each class's label info
  text_labels <- rbind(text_labels, data.frame(x = max_x, y = max_y * 1.05, label = sprintf("R = %.2f; P = %s", r_value, p_value), class = class))
}

## Add text labels using geom_text
plot_scatter_Basic <- plot_scatter_Basic +
  geom_text(data = text_labels, aes(x = x, y = y, label = label, color = class), hjust = 1, vjust = 1, size = 4)

## Beautify the plot by adding title, adjusting text size, and setting aspect ratio
# Customize the plot
plot_scatter <- plot_scatter_Basic +
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
pdf(file = paste0(output_dir,"/",Name_time_wo_micro,"_Scatterplots_Multiple.pdf"), width = 5,  height = 5)

print(plot_scatter)
print(plot_scatter_Basic)


dev.off()

## Export the beautified plot to a TIFF file
tiff(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplot_Multiple.tiff"), width = 5, height = 5, units = "in", res = 300)

print(plot_scatter)

dev.off()

## Export the beautified plot to a JPG file
jpeg(file = paste0(output_dir, "/", Name_time_wo_micro, "_Scatterplot_Multiple.jpg"), width = 5, height = 5, units = "in", res = 300)

print(plot_scatter)

dev.off()

#### ============================================================================== ####
#### Demo ChatGPT ####
## Prompt: Please help me change the drawing to Boxplot
if(!require('ggplot2')) {install.packages('ggplot2'); library(ggplot2)}
if(!require('reshape2')) {install.packages('reshape2'); library(reshape2)}

# Reshape data for boxplot
data_long <- melt(data, id.vars = "Class", measure.vars = c("Gene1", "Gene2"),
                  variable.name = "Gene", value.name = "Expression")

# Create boxplot
plot_boxplot <- ggplot(data_long, aes(x = Gene, y = Expression, fill = Class)) +
  geom_boxplot() +
  theme_bw() +  # White background
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 16),
    panel.border = element_rect(color = "black", linewidth = 1.5),  # Black thick border
    aspect.ratio = 1  # Ensure the plot is square
  ) +
  ggtitle("Boxplot of Gene Expression Levels") +
  ylab("Expression Levels") +
  xlab("Genes")

print(plot_boxplot)


#### ANOVA Analysis ####
## Prompt: There are 3 classes, please add the p-value for each Gene.
if(!require('ggplot2')) {install.packages('ggplot2'); library(ggplot2)}
if(!require('reshape2')) {install.packages('reshape2'); library(reshape2)}
if(!require('dplyr')) {install.packages('dplyr'); library(dplyr)}

# Reshape data for boxplot
data_long <- melt(data, id.vars = "Class", measure.vars = c("Gene1", "Gene2"),
                  variable.name = "Gene", value.name = "Expression")

# Calculate p-values for each gene
p_values <- data_long %>%
  group_by(Gene) %>%
  summarise(p_value = format.pval(anova(lm(Expression ~ Class))$`Pr(>F)`[1], digits = 3))

# Create boxplot
plot_boxplot <- ggplot(data_long, aes(x = Gene, y = Expression, fill = Class)) +
  geom_boxplot() +
  theme_bw() +  # White background
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 16),
    panel.border = element_rect(color = "black", linewidth = 1.5),  # Black thick border
    aspect.ratio = 1  # Ensure the plot is square
  ) +
  ggtitle("Boxplot of Gene Expression Levels") +
  ylab("Expression Levels") +
  xlab("Genes")

# Add p-values to the plot
for (i in 1:nrow(p_values)) {
  plot_boxplot <- plot_boxplot +
    annotate("text", x = i, y = max(data_long$Expression) * 1.05,
             label = paste("p =", p_values$p_value[i]), size = 5, hjust = 0.5)
}

print(plot_boxplot)
