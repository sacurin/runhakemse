load_all("../pacifichakemse/")

ss_model_yr <- 2018
ss_model_output_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                 "extdata", paste0("SS3_", ss_model_yr))
ss_model_data_csv_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                   "extdata", "csv-data")

ss_model <- load_ss_model_data(ss_model_output_dir = ss_model_output_dir,
                               ss_model_data_csv_dir = ss_model_data_csv_dir,
                               load_extra_mcmc = FALSE,
                               overwrite_ss_rds = TRUE)

om <- load_data_om(ss_model, yr_future = 5, rdev_seed = 42)
#om <- load_data_om(ss_model, n_sim_yrs = 5, rdev_seed = 42)

om$selectivity_change <- 0
om0 <- run_om(om, verbose = FALSE)
stop()
om$selectivity_change <- 1
om1 <- run_om(om, verbose = FALSE)

om$selectivity_change <- 2
om2 <- run_om(om, verbose = FALSE)

cat(green(symbol$tick),
    green("Ran selectivity OMs successfully\n"))

