library(PacifichakeMSE)
.seed <- 12345

# Prepare data for operating model
df <- load_data_seasons(nseason = 4,
                        nspace = 2,
                        bfuture = 0.5,
                        movemaxinit = 0.5,
                        movefiftyinit =8)
time <- 1
yrinit <- df$nyear
nruns <- 100
simyears <- 30 # Project this many years into the future
yrs <- df$years
first_sim_yr <- max(yrs) + 1
last_sim_yr <- first_sim_yr + simyears - 1
year.future <- c(yrs, first_sim_yr:last_sim_yr)
N0 <- NA
# Run the operating model until last_yr
sim.data <- run.agebased.true.catch(df, .seed)
simdata0 <- sim.data # The other one is gonna get overwritten.

folders <- 'results/Selectivity/'
