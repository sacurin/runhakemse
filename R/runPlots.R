results_dir <- here::here("results/climate")
po_climate <- setup_mse_plot_objects(results_dir = results_dir,
                                     short_term_yrs = 2018:2027,
                                     long_term_yrs = 2027,
                                     can.prop = 0.2488,
                                     us.prop = 0.7612,
                                     quants = c(0.05, 0.25, 0.5, 0.75, 0.95),
                                     plotexp = TRUE)
saveRDS(po_climate, file = file.path(results_dir, "po_climate.rds"))

# ps_hcr <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
#                                  plotexp = TRUE,
#                                  plotnames = c("base scenario",
#                                                "Historical TAC",
#                                                "Realized",
#                                                "Floor 50"))
#
# ps_survey <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
#                                     plotexp = TRUE,
#                                     plotnames = c("survey1",
#                                                   "base scenario",
#                                                   "survey3"),
#                                     pidx = c(2, 1, 3))
#
# ps_biasadjust <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
#                                         plotexp = TRUE,
#                                         plotnames = c("0.87",
#                                                       "0.5",
#                                                       "0"))
#
# ps_selectivity <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
#                                          plotexp = TRUE,
#                                          plotnames = c("base scenario",
#                                                        "US small \nselectivity",
#                                                        "2018 selectivity"))
