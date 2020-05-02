library(dplyr)
library(reshape2)
library(ggplot2)

# This will assign plotnames to what they were when set up before running the MSE
ps_hcr <- setup_mse_plot_objects(results_dir = here::here("results/hcr"))

# This will re-order the scenarios in the plot
ps_hcr <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
                                 porder = c(2, 1, 4, 3))

# This is how you override the original plotnames and use custom ones
ps_hcr <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
                                 plotnames = c("A",
                                               "B",
                                               "C",
                                               "D"))


plot_bars_country(ps_hcr)
plot_bars_country_season(ps_hcr)
plot_violins_country(ps_hcr)
plot_violins(ps_hcr)
plot_ssb(ps_hcr)
plot_catch(ps_hcr)
plot_ams(ps_hcr)
