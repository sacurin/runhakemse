library(dplyr)
library(reshape2)
library(ggplot2)
ps_hcr <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
                                 plotexp = TRUE,
                                 plotnames = c("base scenario",
                                               "Historical TAC",
                                               "Realized",
                                               "Floor 50"))

plot_bars_country(ps_hcr)
plot_bars_country_season(ps_hcr)
plot_violins_country(ps_hcr)
plot_violins(ps_hcr)
