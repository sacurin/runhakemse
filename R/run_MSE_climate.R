library(PacifichakeMSE)
library(here)
library(purrr)
library(stringr)

results_root_dir <- here("results")
results_dir <- here("results", "climate")
ss_model_output_dir = "C:/github/pacific-hake/hake-assessment/models/2020.01.09_DMprior_base"

fns = c("01_MSErun_move_JMC_climate_0_HYBR_TAC3",
        "02_MSErun_move_JMC_climate_0_02_HYBR_TAC3",
        "03_MSErun_move_JMC_climate_0_04_HYBR_TAC3")

plotnames <-c("Base scenario",
              "Medium increase",
              "High increase")

ages <- 0:20
run_mses(ss_model_output_dir = ss_model_output_dir,
         n_runs = 2,
         n_sim_yrs = 1,
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
         season_names = c("Season1", "Season2", "Season3", "Season4"),
         n_space = 2,
         space_names = c("Canada", "US"),
         s_yr = 1966,
         m_yr = 2018,
         ages = ages,
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
         selectivity_change = 0,
         s_min = 2,
         s_max = 6,
         s_min_survey = 2,
         s_max_survey = 6,
         yr_future  = 0,
         sel_hist = TRUE,
         f_space = c(0.2612, 0.7388),
         catch_props_space_season = list(c(0.001, 0.188, 0.603, 0.208),
                                         c(0.000, 0.317, 0.382, 0.302)),
         pope_mul = 0.5,
         verbose = FALSE)
