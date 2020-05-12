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
         nruns = 2,
         simyears = 3,
         myear = 2018,
         fns = fns,
         plotnames = plotnames,
         tacs = 3,
         cincreases = c(0.0, 0.02, 0.04),
         mincreases = c(0.0, 0.005, 0.02),
         om_params_seed = 12345,
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         nseason = 4,
         nspace = 2,
         bfuture = 0.5)
