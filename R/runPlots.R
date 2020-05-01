ps_climate <- setup_mse_plot_objects(results_dir = here::here("results/climate"),
                                     plotexp = TRUE,
                                     plotnames = c("base scenario",
                                                   "medium increase",
                                                   "high increase"))


ps_hcr <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
                                 plotexp = TRUE,
                                 plotnames = c("base scenario",
                                               "Historical TAC",
                                               "Realized",
                                               "Floor 50"))

ps_survey <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
                                    plotexp = TRUE,
                                    plotnames = c("survey1",
                                                  "base scenario",
                                                  "survey3"),
                                    pidx = c(2, 1, 3))

ps_biasadjust <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
                                        plotexp = TRUE,
                                        plotnames = c("0.87",
                                                      "0.5",
                                                      "0"))

ps_selectivity <- setup_mse_plot_objects(results_dir = here::here("results/hcr"),
                                         plotexp = TRUE,
                                         plotnames = c("base scenario",
                                                       "US small \nselectivity",
                                                       "2018 selectivity"))
