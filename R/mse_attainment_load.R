# If you want to load a single group of scenarios from a single directory for plotting, this is how you do it

load_all("../pacifichakemse/")
ps <- load_mse_plot_data(scenario = "mse_attainment",
                         om_only = FALSE,
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