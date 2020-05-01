library(PacifichakeMSE)
library(here)
library(purrr)
library(stringr)

results_root_dir <- here("results")
results_dir <- here("results", "biasadjust")
fns <- c("MSErun_move_nofishing_nobiasadj",
         "MSErun_move_nofishing_biasadj",
         "MSErun_move_nofishing_biasadj_med")

run_mses(ss_extdata_dir = "SS32018",
         nruns = 2,
         simyears = 3,
         fns = fns,
         om_params_seed = 12345,
         multiple_season_data = list(c(nseason = 4,
                                       nspace = 2,
                                       bfuture = 0),
                                     c(nseason = 4,
                                       nspace = 2,
                                       bfuture = 0.87),
                                     c(nseason = 4,
                                       nspace = 2,
                                       bfuture = 0.5)),
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         nseason = 4,
         nspace = 2,
         bfuture = 0.5)
