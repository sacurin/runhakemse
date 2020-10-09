load_all("../pacifichakemse/")

# Number of years to simulate into the future
n_sim_yrs <- 4

ss_model_output_dir <- "C:/tmp/PacifichakeMSE/inst/extdata/SS32018"
ss_model_raw <- load_ss_model_from_rds(ss_model_output_dir,
                                       load_extra_mcmc = FALSE)
ss_model <- load_ss_model_data(ss_model_raw,
                               s_yr = 1966,
                               m_yr = 2018)
om <- load_data_om(ss_model,
                   n_sim_yrs,
                   catch_props_space_season = list(c(0.001, 0.188, 0.603, 0.208),
                                                       c(0.000, 0.317, 0.382, 0.302)))
om <- run_om(om,
             random_seed = 42,
             verbose = FALSE)
