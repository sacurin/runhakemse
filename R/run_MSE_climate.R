library(PacifichakeMSE)
library(here)

results_root_dir <- here("results")
results_dir <- file.path(results_root_dir, "climate")
#ss_model_output_dir <- "C:/github/pacific-hake/hake-assessment/models/2020.01.09_DMprior_base"
ss_model_output_dir <- "C:/tmp/PacifichakeMSE/inst/extdata/SS32018"
#ss_model_output_dir <- "C:/WORK/A_Species/Hake/2018/models/2018.40_base_model"

fns = c("01_MSErun_move_JMC_climate_00_HYBR_TAC3",
        "02_MSErun_move_JMC_climate_02_HYBR_TAC3",
        "03_MSErun_move_JMC_climate_04_HYBR_TAC3")

plotnames <-c("Base scenario",
              "Medium increase",
              "High increase")

# The list of same length as the number of scenarios, one item for each scenario
# If zero, not used, else a vector of two, the in season catch and the slippage
# which is multiplied by the new catch
tacs <- list(c(0, 1),
             c(0, 1),
             c(0, 1))

ages <- 0:20
run_mses(ss_model_output_dir = ss_model_output_dir,
         overwrite_ss_rds = FALSE,
         n_runs = 30,
         n_sim_yrs = 30,
         sel_change_yr = 1991,
         fns = fns,
         plot_names = plotnames,
         tacs = tacs,
         # If sel_changes, c_increases, or m_increases are length 1, that value will be used for all scenarios
         # If it is a vector, it must be the same length as the number of scenarios or an error will be thrown
         c_increases = c(0.00, 0.02, 0.04),
         m_increases = c(0.00, 0.005, 0.02),
         sel_changes = 0,
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
         s_min = 1,
         s_max = 6,
         s_min_survey = 2,
         s_max_survey = 6,
         yr_future  = 0,
         sel_hist = TRUE,
         f_space = c(0.2612, 0.7388),
         log_phi_survey = log(11.46),
         catch_floor = 180000,
         catch_props_space_season = list(c(0.001, 0.188, 0.603, 0.208),
                                         c(0.000, 0.317, 0.382, 0.302)),
         pope_mul = 0.5,
         verbose = FALSE)
