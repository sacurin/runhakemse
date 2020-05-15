library(PacifichakeMSE)
library(here)

# How to debug TMB DLLs:
#https://github.com/kaskr/adcomp/issues/254
# TMB::gdbsource("R/run_MSE_HCR.R", interactive = TRUE)

results_root_dir <- here("results")
results_dir <- here("results", "hcr")

fns <- c("01_MSE_A_HCR",
         "02_MSE_B_JMC",
         "03_MSE_C_realized",
         "04_MSE_D_Floor50")

plotnames <- c("Base scenario",
               "Historical TAC",
               "Realized",
               "Floor 50")

run_mses(ss_extdata_dir = "SS32018",
         nruns = 2,
         simyears = 30,
         syear = 1966,
         myear = 2018,
         ages = 0:20,
         sel_change_yr = 1991,
         fns = fns,
         plotnames = plotnames,
         tacs = 1:4,
         om_params_seed = 12345,
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         nseason = 4,
         nspace = 2,
         bfuture = 0.5)
