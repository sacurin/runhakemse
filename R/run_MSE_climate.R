library(PacifichakeMSE)
library(purrr)
library(here)
library(r4ss)
.seed <- 12345
results_dir <- "climate"
nruns <- 2
simyears <- 3

mod <- SS_output(system.file("extdata/SS32018/",
                             package = "PacifichakeMSE",
                             mustWork = TRUE),
                 printstats = FALSE,
                 verbose = FALSE)

# Prepare data for operating model
df <- load_data_seasons(nseason = 4,
                        nspace = 2,
                        bfuture = 0.5)

# Load parameters from assessment
parms.true <- getParameters_OM(TRUE, mod, df)

seeds <- floor(runif(n = nruns, min = 1, max = 1e6))
yrs <- df$years
first_sim_yr <- max(yrs) + 1
last_sim_yr <- first_sim_yr + simyears - 1
year.future <- c(yrs, first_sim_yr:last_sim_yr)

# Run the operating model until last_yr
sim.data <- run.agebased.true.catch(df, .seed)

fns <- c("MSErun_move_JMC_climate_0_04_HYBR_TAC1.rds",
         "MSErun_move_JMC_climate_0_HYBR_TAC3.rds",
         "MSErun_move_JMC_climate_0_02_HYBR_TAC3.rds",
         "MSErun_move_JMC_climate_0_04_HYBR_TAC3.rds")
vals <- list(tacs = c(1, 3, 3, 3),
             cincreases = c(0.04, 0.0, 0.02, 0.04),
             mincreases = c(0.02, 0.0, 0.005, 0.02))
len <- 1:length(fns)
if(!dir.exists(here("results"))){
  dir.create(here("results"))
}
if(!dir.exists(here("results", results_dir))){
  dir.create(here("results", results_dir))
}

# Loop MSEs
map2(fns, len, ~{
  ls_save <- map(1:nruns, function(run = .x, ...){
    tmp <- run_multiple_MSEs(simyears = simyears,
                             seeds = seeds[run],
                             TAC = vals$tacs[.y],
                             df = df,
                             cincrease = vals$cincreases[.y],
                             mincrease = vals$mincreases[.y])
    ifelse(is.list(tmp), tmp, NA)
  }, ...)
  saveRDS(ls_save, file = here("results", results_dir, .x))
})

