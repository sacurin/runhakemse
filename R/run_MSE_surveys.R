library(PacifichakeMSE)

fns <- c("MSE_Real_Survey1.rds",
         "MSE_Real_Survey2.rds",
         "MSE_Real_Survey3.rds")

plotnames <- c("Survey1",
               "Base scenario",
               "Survey3")

run_mses(ss_extdata_dir = "SS32018",
         nruns = 2,
         simyears = 3,
         fns = fns,
         plotnames = plotnames,
         tacs = 1,
         nsurveys = 1:3,
         om_params_seed = 12345,
         results_root_dir = here("results"),
         results_dir = here("results", "survey"),
         nseason = 4,
         nspace = 2,
         bfuture = 0.5)
