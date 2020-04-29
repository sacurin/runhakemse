library(PacifichakeMSE)
library(purrr)
library(here)
library(r4ss)
.seed <- 12345

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

time <- 1
yrinit <- df$nyear
nruns <- 2
seeds <- floor(runif(n = nruns, min = 1, max = 1e6))
simyears <- 3 # Project this many years into the future
yrs <- df$years
first_sim_yr <- max(yrs) + 1
last_sim_yr <- first_sim_yr + simyears - 1
year.future <- c(yrs, first_sim_yr:last_sim_yr)
N0 <- NA
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
if(!dir.exists(here("results", "HCR"))){
  dir.create(here("results", "HCR"))
}

# Loop MSEs with different errors in future survey and recruitment
map2(fns, tacs, ~{
  ls_save <- map2(.y, 1:nruns, ~{
    tmp <- run_multiple_MSEs(simyears = simyears,
                             seeds = seeds[.y],
                             TAC = .x,
                             df = df)
    ifelse(is.list(tmp), tmp, NA)
  })
  saveRDS(ls_save, file = here("results", "HCR", .x))
})
