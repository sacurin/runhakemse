load_all("../pacifichakemse/")
library(here)

results_root_dir <- here("results")
results_dir <- file.path(results_root_dir, "biasadjust")

fns <- "MSErun_move_nofishing_biasadj_med"

plotnames <- "Bias 0.5"

ss_model_yr <- 2018
ss_model_output_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                 "extdata", paste0("SS3_", ss_model_yr))
ss_model_data_csv_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                   "extdata", "csv-data")

ss_model <- load_ss_model_data(ss_model_output_dir = ss_model_output_dir,
                               ss_model_data_csv_dir = ss_model_data_csv_dir,
                               load_extra_mcmc = FALSE,
                               overwrite_ss_rds = TRUE)

run_oms(ss_model = ss_model,
        n_runs = 100,
        yr_future = 50,
        fns = fns,
        n_surveys = 2,
        b_futures = 0.5,
        c_increases = 0,
        m_increases = 0,
        sel_changes = 0,
        catch_in = 0,
        plot_names = plotnames,
        random_seed = 12345,
        results_root_dir = results_root_dir,
        results_dir = results_dir)