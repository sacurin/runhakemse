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
plot_aa(ps_hcr, type = "survey")
plot_aa(ps_hcr, type = "catch")
plot_aa_country(ps_hcr, type = "survey", country_colors = c("darkred", "blue4"))
plot_aa_country(ps_hcr, type = "catch", country_colors = c("darkred", "blue4"))
plot_standard_error(ps_hcr)
plot_exploitation_rate(ps_hcr) +
  coord_cartesian(ylim = c(0.0, 1.0))
plot_catch_quota(ps_hcr) +
  coord_cartesian(ylim = c(0.8, 1.1))
plot_catch_quota_1panel(ps_hcr) +
  coord_cartesian(ylim = c(0.8, 1.1))
plot_ssb_ssb0(ps_hcr) +
  coord_cartesian(ylim = c(0.0, 2.0)) +
  geom_ribbon(aes(ymin = p5, ymax = p95), linetype = 0)
plot_catch_quota_1panel(ps_hcr)
