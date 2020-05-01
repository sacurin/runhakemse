library(PacifichakeMSE)
library(here)
library(purrr)
library(stringr)

results_root_dir <- here("results")
results_dir <- here("results", "climate")
fns = c(#"MSErun_move_JMC_climate_0_04_HYBR_TAC1",
        "MSErun_move_JMC_climate_0_HYBR_TAC3",
        "MSErun_move_JMC_climate_0_02_HYBR_TAC3",
        "MSErun_move_JMC_climate_0_04_HYBR_TAC3")

run_mses(ss_extdata_dir = "SS32018",
         nruns = 2,
         simyears = 3,
         fns = fns,
         tacs = c(1, 3, 3, 3),
         cincreases = c(0.04, 0.0, 0.02, 0.04),
         mincreases = c(0.02, 0.0, 0.005, 0.02),
         om_params_seed = 12345,
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         nseason = 4,
         nspace = 2,
         bfuture = 0.5)

# Make the plots - see plotClimateMSEs.R
fns <- fns[-1]
fns <- map_chr(fns, ~{
  ifelse(str_ends(.x, pattern = "\\.rds"), .x, paste0(.x, ".rds"))
})
out <- map(fns, ~{
  readRDS(here(results_root_dir, results_dir, .x))
})

names(out) <- c("base model", "medium change", "high change")
df <- load_data_seasons(nseason = 4, nspace = 2, bfuture = 0.5)
sim.data <- run.agebased.true.catch(df)
# TODO: Fix this error
fn_plot_MSE(out, sim.data, plotfolder = results_dir, plotexp = TRUE)
