# 安装并加载所需的包
if(!require("tidyverse")) install.packages("tidyverse"); library(tidyverse)
if(!require("pheatmap")) install.packages("pheatmap"); library(pheatmap)

# 示例元数据
metadata <- data.frame(
  SampleID = c("S1", "S2", "S3", "S4"),
  Group = c("Control", "Control", "Treatment", "Treatment"),
  TimePoint = c("T1", "T2", "T1", "T2")
)

# 示例表达矩阵
expression_matrix <- matrix(
  c(5.1, 4.5, 3.2, 3.8,
    6.2, 5.9, 4.3, 4.8,
    2.9, 2.8, 1.2, 1.1),
  nrow = 3, ncol = 4, byrow = TRUE
)
rownames(expression_matrix) <- c("GeneA", "GeneB", "GeneC")
colnames(expression_matrix) <- c("S1", "S2", "S3", "S4")

# 绘制热图
annotation_col <- metadata %>% column_to_rownames("SampleID")
pheatmap(expression_matrix, annotation_col = annotation_col)

# 数据处理和可视化
# 转换表达矩阵为数据框格式
expression_df <- as.data.frame(t(expression_matrix))
expression_df$SampleID <- rownames(expression_df)
expression_df <- expression_df %>% pivot_longer(-SampleID, names_to = "Gene", values_to = "Expression")

# 合并元数据
expression_df <- expression_df %>% left_join(metadata, by = "SampleID")

# 绘制箱线图
ggplot(expression_df, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot() +
  facet_wrap(~ Gene, scales = "free_y") +
  theme_minimal() +
  ggtitle("Gene Expression by Group")
