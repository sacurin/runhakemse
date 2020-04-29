library(PacifichakeMSE)
library(purrr)
library(here)
library(r4ss)
.seed <- 12345
results_dir <- "survey"
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

sim.data <- run.agebased.true.catch(df) # Run the operating model until 2018

# MSE TAC types for the function run_multiple_MSEs()
fns <- c("MSE_Real_Survey1.rds",
         "MSE_Real_Survey2.rds",
         "MSE_Real_Survey3.rds")
dfs <- rep(list(df), length(fns))
dfs <- map2(dfs, 1:length(dfs), ~{
  .x$nsurvey <- .y
  .x
})
if(!dir.exists(here("results"))){
  dir.create(here("results"))
}
if(!dir.exists(here("results", results_dir))){
  dir.create(here("results", results_dir))
}

# Loop MSEs
map2(fns, dfs, ~{
  ls_save <- map(1:nruns, function(run = .x, ...){
    tmp <- run_multiple_MSEs(simyears = simyears,
                             seeds = seeds[run],
                             TAC = 1,
                             df = .y)
    ifelse(is.list(tmp), tmp, NA)
  }, ...)
  saveRDS(ls_save, file = here("results", results_dir, .x))
})
