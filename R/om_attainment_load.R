# If you want to load a single group of scenarios from a single directory for plotting, this is how you do it

load_all("../pacifichakemse/")
ps <- load_mse_plot_data(scenario = "om_attainment_recr_hcr_default_catch",
                         om_only = TRUE,
                         overwrite_rds = FALSE,
                         short_term_yrs = 2018:2027,
                         long_term_yrs = 2027,
                         main_results_dir = "results")

ps_nohcr <- load_mse_plot_data(scenario = "om_attainment_recr_nohcr_default_catch",
                               om_only = TRUE,
                               overwrite_rds = FALSE,
                               short_term_yrs = 2018:2027,
                               long_term_yrs = 2027,
                               main_results_dir = "results")

ps_1e6 <- load_mse_plot_data(scenario = "om_attainment_recr_hcr_1e6catch",
                             om_only = TRUE,
                             overwrite_rds = FALSE,
                             short_term_yrs = 2018:2027,
                             long_term_yrs = 2027,
                             main_results_dir = "results")
plot_timeseries(ps,
                type = "ssb",
                ci_lines = T,
                yr_lim = c(2010, NA), ylim = c(0, 5))

plot_timeseries_runs(ps,
                     type = "ssb")