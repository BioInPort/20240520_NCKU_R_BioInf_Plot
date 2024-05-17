## Ref: https://ggplot2.tidyverse.org/reference/geom_point.html

#### Presetting ####
rm(list = ls()) # Clean variable ##* Comment out if Run All
# memory.limit(150000)


#### Load packages ####
if(!require("ggplot2")) install.packages("ggplot2"); library(ggplot2)


#### Load Data ####
data <- data.frame(
  x = rnorm(50),
  y = rnorm(50)
)

#### Visualization ####
p <- ggplot(data, aes(x=x, y=y)) +
  geom_point() +
  stat_summary(fun.data=mean_sdl, fun.args = list(mult=1), geom="errorbar", color="red")
print(p)

#### Export ####
## Export PDF
pdf(file = paste0("_Scatterplots.pdf"), width = 7,  height = 7)

print(p)

dev.off()

## Export TIFF


## Export JPG





