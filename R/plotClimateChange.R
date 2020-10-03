library(PacifichakeMSE)
library(dplyr)
library(reshape2)
library(ggplot2)

tictoc::tic()
results_dir <- here::here("results/climate")
po_filename <- file.path(results_dir, "po_climate.rds")
if(file.exists(po_filename)){
  po_climate <- readRDS(po_filename)
}else{
  po_climate <- setup_mse_plot_objects(results_dir = results_dir,
                                       short_term_yrs = 2018:2027,
                                       long_term_yrs = 2027,
                                       can.prop = 0.2488,
                                       us.prop = 0.7612,
                                       quants = c(0.05, 0.25, 0.5, 0.75, 0.95),
                                       plotexp = TRUE)
  saveRDS(po_climate, file = po_filename)
}
tictoc::toc()

# This will re-order the scenarios in the plots
# ps_climate <- setup_mse_plot_objects(results_dir = here::here("results/climate"),
#                                      porder = c(2, 1, 4, 3))

# This is how you override the original plotnames and use custom ones
# ps_climate <- setup_mse_plot_objects(results_dir = here::here("results/climate"),
#                                      plotnames = c("A",
#                                                    "B",
#                                                    "C",
#                                                    "D"))


plot_bars_country(po_climate)
plot_bars_country_season(po_climate)
plot_violins(po_climate)
# TODO: Fix plot_violins_country
plot_violins_country(po_climate)
plot_ssb(po_climate)
plot_catch(po_climate)
# TODO: Make sure these are totals, not by country for plot_aa
plot_aa(po_climate, type = "survey")
plot_aa(po_climate, type = "catch")
plot_aa_country(po_climate, type = "survey", country_colors = c("darkred", "blue4"))
plot_aa_country(po_climate, type = "catch", country_colors = c("darkred", "blue4"))
plot_standard_error(po_climate)
plot_exploitation_rate(po_climate) +
  coord_cartesian(ylim = c(0.0, 1.0))
# TODO: Fix this - it needs to be divided by catch
plot_catch_quota(po_climate) +
  coord_cartesian(ylim = c(0.8, 1.1))
plot_catch_quota_1panel(po_climate) +
  coord_cartesian(ylim = c(0.8, 1.1))
plot_ssb_ssb0(po_climate) +
  coord_cartesian(ylim = c(0.0, 2.0)) +
  geom_ribbon(aes(ymin = p5, ymax = p95), linetype = 0)
plot_catch_quota_1panel(po_climate)
