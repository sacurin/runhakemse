#library(pacifichakemse)
load_all("../pacifichakemse")
library(here)

results_root_dir <- here("results")
results_dir <- file.path(results_root_dir, "om_attainment_norecr_hcr")

ss_model_yr <- 2018
ss_model_output_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                 "extdata", paste0("SS3_", ss_model_yr))
ss_model_data_csv_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                   "extdata", "csv-data")

fns <- "03_us_100_can_0"

plotnames <- "Full attainment US, no CAN fishery"

ss_model <- load_ss_model_data(ss_model_output_dir = ss_model_output_dir,
                               ss_model_data_csv_dir = ss_model_data_csv_dir,
                               load_extra_mcmc = FALSE,
                               overwrite_ss_rds = TRUE)

run_oms(ss_model = ss_model,
        n_runs = 1,
        yr_future = 50,
        fns = fns,
        n_surveys = 2,
        b_futures = 0,
        c_increases = 0,
        m_increases = 0,
        sel_changes = 0,
        #catch_in = 1e6,
        attain = c(0, 1), # Canada, US attainment 0-1
        tac = c(0, 1),
        hcr_apply = T,
        hcr_lower = 0.1,
        hcr_upper = 0.4,
        hcr_fspr = 0.4,
        include_recruitment = F,
        plot_names = plotnames,
        random_seed = 12345,
        results_root_dir = results_root_dir,
        results_dir = results_dir)