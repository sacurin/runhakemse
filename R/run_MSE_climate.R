library(PacifichakeMSE)
library(here)
library(purrr)
library(stringr)

results_root_dir <- here("results")
results_dir <- here("results", "climate")

fns = c("01_MSErun_move_JMC_climate_0_HYBR_TAC3",
        "02_MSErun_move_JMC_climate_0_02_HYBR_TAC3",
        "03_MSErun_move_JMC_climate_0_04_HYBR_TAC3")

plotnames <-c("Base scenario",
              "Medium increase",
              "High increase")

run_mses(ss_extdata_dir = "SS32018",
         n_runs = 2,
         n_sim_yrs = 3,
         sel_change_yr = 1991,
         fns = fns,
         plot_names = plotnames,
         tacs = 3,
         c_increases = c(0.0, 0.02, 0.04),
         m_increases = c(0.0, 0.005, 0.02),
         om_params_seed = 12345,
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         # Arguments to load_data_seasons(), for OM setup
         n_season = 4,
         n_space = 2,
         s_yr = 1966,
         m_yr = 2018,
         ages = 0:20,
         move_max_init = 0.35,
         move_fifty_init = 6,
         n_surveys = rep(2, length(fns)),
         rdev_sd = 1.4,
         b_future = 0.5,
         move_out = 0.85,
         move_south = 0.05,
         move_init = NULL,
         move_slope = 0.9,
         selectivity_change = 0,
         yr_future  = 0,
         sel_hist = TRUE)
