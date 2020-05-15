library(PacifichakeMSE)
library(ggplot2)

df <- calc_tac_est_vs_real(catch_floor = 180000)

plot_tac_est_vs_real(df)
plot_tac_vs_hcr(df) +
  coord_cartesian(ylim = c(0, 800), xlim = c(0, 1000))

# Remove "floor" from the previous plot
df$plot <- df$plot %>%
  filter(HCR != "floor")
attr(df$plot, "cols") <- attr(df$plot, "cols")[1:3]
plot_tac_vs_hcr(df, labels = c("Base scenario", "Historical", "Realized")) +
  coord_cartesian(ylim = c(0, 800), xlim = c(0, 1000))
