library(pacifichakemse)
library(here)

results_root_dir <- here("results")
results_dir <- file.path(results_root_dir, "climate")

ss_model_output_dir <- "C:/tmp/PacifichakeMSE/inst/extdata/SS32018"

fns <- c("01_MSErun_move_JMC_climate_00_HYBR_TAC3",
         "02_MSErun_move_JMC_climate_02_HYBR_TAC3",
         "03_MSErun_move_JMC_climate_04_HYBR_TAC3")

plotnames <- c("Base scenario",
               "Medium increase",
               "High increase")

# List of vectors (of two) of the same length as the number of scenarios, one vector for each scenario
# For each vector of two e.g. c(a, b): the new catch in the OM is c_new * b + a
# If a single value (use zero) instead of a vector, the new catch in the OM is c_new * 0.5 unless
# below catch_floor in which case it is c_new = catch_floor
# In any event, if the calculation is greater than c_new, c_new will be used instead
tacs <- list(c(0, 1),
             c(0, 1),
             c(0, 1))

# A vector with one element for each scenario, which is additional proportion of the stock to be
# moved from space 2 to space 1 (into Canada). If a single value instead of a vector, that value
# will be used for all scenarios.
movein_increases <- c(0.00, 0.02, 0.04)
# A vector with one element for each scenario, which is additional proportion of the stock to be
# moved from space 1 to space 2 (out of Canada). If a single value instead of a vector, that value
# will be used for all scenarios.
moveout_decreases <- c(0.00, 0.005, 0.02)

sel_changes <- 0

run_mses(ss_model_output_dir = ss_model_output_dir,
         overwrite_ss_rds = FALSE,
         n_runs = 30,
         n_sim_yrs = 30,
         sel_change_yr = 1991,
         fns = fns,
         plot_names = plotnames,
         tacs = tacs,
         c_increases = movein_increases,
         m_increases = moveout_decreases,
         sel_changes = sel_changes,
         f_sim = 0.2,
         random_seed = 12345,
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         ss_mcmc_quants = c(0.025, 0.5, 0.975),
         load_extra_mcmc = FALSE,
         # Arguments to load_data_seasons(), for OM setup
         n_season = 4,
         season_names = c("Season1", "Season2", "Season3", "Season4"),
         n_space = 2,
         space_names = c("Canada", "US"),
         s_yr = 1966,
         m_yr = 2018,
         ages = 0:20,
         age_names = paste("age", ages),
         move_max_init = 0.35,
         move_fifty_init = 6,
         n_surveys = rep(2, length(fns)),
         rdev_sd = 1.4,
         b_future = 0.5,
         move_out = 0.85,
         move_south = 0.05,
         move_init = NULL,
         move_slope = 0.9,
         ages_no_move = c(0, 1),
         s_min = 1,
         s_max = 6,
         s_min_survey = 2,
         s_max_survey = 6,
         # Value to use for final ages s_max and s_max_survey (typically 1 but can be set less here)
         selex_fill_val = 1,
         yr_future  = 0,
         sel_hist = TRUE,
         f_space = c(0.2612, 0.7388),
         log_phi_survey = log(11.46),
         catch_floor = 180000,
         catch_props_space_season = list(c(0.001, 0.188, 0.603, 0.208),
                                         c(0.000, 0.317, 0.382, 0.302)),
         pope_mul = 0.5,
         verbose = FALSE)
