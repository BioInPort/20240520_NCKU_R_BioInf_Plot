## Ref: https://ggplot2.tidyverse.org/reference/geom_point.html





data <- data.frame(
  x = rnorm(50),
  y = rnorm(50)
)

p <- ggplot(data, aes(x=x, y=y)) +
  geom_point() +
  stat_summary(fun.data=mean_sdl, fun.args = list(mult=1), geom="errorbar", color="red")
print(p)
