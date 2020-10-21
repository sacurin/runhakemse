load_all("../pacifichakemse/")

set.seed(12345)
seed <- floor(runif(n = 1, min = 1, max = 1e6))

ss_model_yr <- 2018
ss_model_output_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                 "extdata", paste0("SS3_", ss_model_yr))
ss_model_data_csv_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                   "extdata", "csv-data")

ss_model <- load_ss_model_data(ss_model_output_dir = ss_model_output_dir,
                               ss_model_data_csv_dir = ss_model_data_csv_dir,
                               load_extra_mcmc = FALSE,
                               overwrite_ss_rds = TRUE)

om <- load_data_om(ss_model, yr_future = 5)
#om <- load_data_om(ss_model, n_sim_yrs = 5)

om$selectivity_change <- 0
om0 <- run_om(om, random_seed = seed, verbose = FALSE)
stop()
om$selectivity_change <- 1
om1 <- run_om(om, random_seed = seed, verbose = FALSE)

om$selectivity_change <- 2
om2 <- run_om(om, random_seed = seed, verbose = FALSE)

cat(green(symbol$tick),
    green("Ran selectivity OMs successfully\n"))

