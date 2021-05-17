# If you want to load a single group of scenarios from a single directory for plotting, this is how you do it

load_all("../pacifichakemse/")
ps <- load_mse_plot_data(scenario = "attainment_catch_recr_hcr_fspr01",
                         om_only = TRUE,
                         overwrite_rds = F,
                         short_term_yrs = 2018:2027,
                         long_term_yrs = 2027,
                         main_results_dir = "results")

ps99 <- load_mse_plot_data(scenario = "mse_attainment99",
                         overwrite_rds = T,
                         short_term_yrs = 2018:2027,
                         long_term_yrs = 2027,
                         main_results_dir = "results")

plot_timeseries(ps,
                type = "ssb",
                ci_lines = T,
                yr_lim = c(2010, NA), ylim = c(0, 5))

plot_timeseries(ps,
                type = "catch",
                ci_lines = FALSE,
                yr_lim = c(2010, NA), ylim = c(0, 0.6))

