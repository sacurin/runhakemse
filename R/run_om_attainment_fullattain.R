#library(pacifichakemse)
load_all("../pacifichakemse")
library(here)

results_root_dir <- here("results")
results_dir <- file.path(results_root_dir, "attainment")

ss_model_yr <- 2018
ss_model_output_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                 "extdata", paste0("SS3_", ss_model_yr))
ss_model_data_csv_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                   "extdata", "csv-data")

fns <- "02_us_100_can_100"

plotnames <- "Full attainment coastwide"

ss_model <- load_ss_model_data(ss_model_output_dir = ss_model_output_dir,
                               ss_model_data_csv_dir = ss_model_data_csv_dir,
                               load_extra_mcmc = FALSE,
                               overwrite_ss_rds = TRUE)

run_oms(ss_model = ss_model,
        n_runs = 100,
        yr_future = 50,
        fns = fns,
        n_surveys = 2,
        b_futures = 0,
        c_increases = 0,
        m_increases = 0,
        sel_changes = 0,
        catch_in = 0,
        zero_catch_val = 0,
        attain = c(1, 1), # Canada, US attainment 0-1
        upper_ref = 0.5,
        f_ref = 0.4,
        set_rec_devs_zero = FALSE,
        plot_names = plotnames,
        random_seed = 12345,
        results_root_dir = results_root_dir,
        results_dir = results_dir)