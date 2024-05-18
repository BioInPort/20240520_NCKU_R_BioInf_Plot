## [Cheatsheets] https://posit.co/resources/cheatsheets/

#### Presetting ####
rm(list = ls()) # Clean variable ##* Comment out if Run All
# memory.limit(150000)


#### Load packages ####
if(!require("tidyverse")) install.packages("tidyverse"); library(tidyverse)


#### Create data ####
## Basic scatterplots
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



