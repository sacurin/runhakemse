# If you want to load a single group of scenarios from a single directory for plotting, this is how you do it

load_all("../pacifichakemse/")
ps1 <- load_mse_plot_data(scenario = "test_unfished",
                          overwrite_rds = TRUE,
                          short_term_yrs = 2018:2027,
                          long_term_yrs = 2027,
                          main_results_dir = "results")

ps <- load_mse_plot_data(scenario = "attainment",
                          overwrite_rds = TRUE,
                          short_term_yrs = 2018:2027,
                          long_term_yrs = 2027,
                          main_results_dir = "results")

ps <- create_plot_objects(scenario = "perfect_information",
                          om_only = TRUE,
                          overwrite_rds = TRUE,
                          short_term_yrs = 2018:2027,
                          long_term_yrs = 2027,
                          main_results_dir = "results")

pb <- load_mse_plot_data(scenario = "biasadjust",
                         om_only = TRUE,
                         overwrite_rds = TRUE,
                         short_term_yrs = 2018:2027,
                         long_term_yrs = 2027,
                         main_results_dir = "results")

plot_timeseries(ps,
                type = "ssb",
                ci_lines = FALSE,
                yr_lim = c(yr_start, NA))
