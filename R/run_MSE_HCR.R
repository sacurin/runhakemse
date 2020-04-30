library(PacifichakeMSE)
library(purrr)
library(here)
library(r4ss)
.seed <- 12345
results_dir <- "HCR"
nruns <- 100
simyears <- 30

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

# MSE TAC types for the function run_multiple_MSEs()
fns <- c("MSE_A_HCR.rds",
         "MSE_B_JMC.rds",
         "MSE_C_realized.rds",
         "MSE_D_Floor50.rds")
tacs <- 1:length(fns)
if(!dir.exists(here("results"))){
  dir.create(here("results"))
}
if(!dir.exists(here("results", results_dir))){
  dir.create(here("results", results_dir))
}

# Loop MSEs
map2(fns, tacs, ~{
  ls_save <- map(1:nruns, function(run = .x, ...){
    tmp <- run_multiple_MSEs(simyears = simyears,
                             seeds = seeds[run],
                             TAC = .y,
                             df = df)
    if(is.list(tmp)) tmp else NA
  }, ...)
  saveRDS(ls_save, file = here("results", results_dir, .x))
})
