load_all("../pacifichakemse/")

ss_model_yr <- 2018
ss_model_output_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                 "extdata", paste0("SS3_", ss_model_yr))
ss_model_data_csv_dir <- "C:/github/pacific-hake/hake-assessment/data"
ss_model_raw <- load_ss_model_from_rds(ss_model_output_dir,
                                       ss_model_data_csv_dir,
                                       load_extra_mcmc = FALSE,
                                       overwrite_ss_rds = FALSE)
ss_model <- load_ss_model_data(ss_model_raw)
om <- load_data_om(ss_model, n_sim_yrs = 5, rdev_seed = 123)
om <- run_om(om, verbose = FALSE)


#p <- compare_move(om)
#do.call("grid.arrange", c(p, ncol = 2))
