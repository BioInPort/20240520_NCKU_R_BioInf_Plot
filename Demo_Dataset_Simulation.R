

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

