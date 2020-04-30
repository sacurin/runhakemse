library(PacifichakeMSE)

fns = c("MSErun_move_JMC_climate_0_04_HYBR_TAC1",
        "MSErun_move_JMC_climate_0_HYBR_TAC3",
        "MSErun_move_JMC_climate_0_02_HYBR_TAC3",
        "MSErun_move_JMC_climate_0_04_HYBR_TAC3")

run_mse_climate(ss_extdata_dir = "SS32018",
                nruns = 2,
                simyears = 3,
                fns = fns,
                tacs = c(1, 3, 3, 3),
                cincreases = c(0.04, 0.0, 0.02, 0.04),
                mincreases = c(0.02, 0.0, 0.005, 0.02),
                om_params_seed = 12345,
                results_root_dir = "results",
                results_dir = "climate",
                nseason = 4,
                nspace = 2,
                bfuture = 0.5)

# Make the plots - see plotClimateMSEs.R
fns <- fns[-1]
fns <- purrr::map_chr(fns, ~{
  ifelse(stringr::str_ends(.x, pattern = "\\.rds"), .x, paste0(.x, ".rds"))
})
legend <- c("base model", "medium change", "high change")
out <- map(fns, ~{
  readRDS(here::here("results", results_dir, .x))
})

names(out) <- legend
fn_plot_MSE(out, sim.data, plotfolder = here::here("results", results_dir), plotexp = TRUE)
