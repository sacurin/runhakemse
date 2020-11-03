# Assumes create_all_plot_object_files.R was run
load_all("../pacifichakemse")

po <- ps$climate

# This will re-order the scenarios in the plots
# ps_climate <- setup_mse_plot_objects(results_dir = here::here("results/climate"),
#                                      porder = c(2, 1, 4, 3))

# This is how you override the original plotnames and use custom ones
# ps_climate <- setup_mse_plot_objects(results_dir = here::here("results/climate"),
#                                      plotnames = c("A",
#                                                    "B",
#                                                    "C",
#                                                    "D"))


theme_set(hake_theme())
stop()
plot_bars_country(po_sel)
plot_bars_country_season(po_sel)
plot_violins(po_sel)
# TODO: Fix plot_violins_country
plot_violins_country(po_sel)

yr_start <- 2010
plot_ssb(po_sel, yr_lim = c(yr_start, NA))
plot_catch(po_sel, yr_lim = c(yr_start, NA))
plot_aa(po_sel, type = "survey", yr_lim = c(yr_start, NA))
plot_aa(po_sel, type = "catch", yr_lim = c(yr_start, NA))
plot_aa_country(po_sel, type = "survey", country_colors = c("darkred", "blue4"), yr_lim = c(yr_start, NA))
plot_aa_country(po_sel, type = "catch", country_colors = c("darkred", "blue4"), yr_lim = c(yr_start, NA))
plot_standard_error(po_sel)
plot_exploitation_rate(po_sel) +
  coord_cartesian(ylim = c(0.0, 1.0))
# TODO: Fix this - it needs to be divided by catch
plot_catch_quota(po_sel) +
  coord_cartesian(ylim = c(0.8, 1.1))
plot_catch_quota_1panel(po_sel) +
  coord_cartesian(ylim = c(0.8, 1.1))
plot_ssb_ssb0(po_sel) +
  coord_cartesian(ylim = c(0.0, 2.0)) +
  geom_ribbon(aes(ymin = p5, ymax = p95), linetype = 0)
plot_catch_quota_1panel(po_sel)
