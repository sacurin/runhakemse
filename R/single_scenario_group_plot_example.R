# If you want to load a single group of scenarios from a single directory for plotting, this is how you do it

ps_c <- load_mse_plot_data(scenario = "climate",
                           overwrite_rds = FALSE,
                           short_term_yrs = 2018:2027,
                           long_term_yrs = 2027,
                           main_results_dir = "results")

plot_timeseries(ps_c,
                type = "ssb",
                ci_lines = FALSE,
                yr_lim = c(yr_start, NA))
