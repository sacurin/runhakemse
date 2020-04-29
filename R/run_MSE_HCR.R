library(PacifichakeMSE)
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
nruns <- 100
seeds <- floor(runif(n = nruns, min = 1, max = 1e6))
simyears <- 3 # Project this many years into the future
yrs <- df$years
first_sim_yr <- max(yrs) + 1
last_sim_yr <- first_sim_yr + simyears - 1
year.future <- c(yrs, first_sim_yr:last_sim_yr)
N0 <- NA
# Run the operating model until last_yr
sim.data <- run.agebased.true.catch(df, .seed)

# Loop MSEs with different errors in future survey and recruitment
ls.save <- list()
ls.converge <- matrix(0, nruns)
for(i in 1:nruns){
  tmp <- run_multiple_MSEs(simyears = simyears,
                           seeds = seeds[i],
                           TAC = 1,
                           df = df)
  #tmp <- run_multiple_MSEs(simyears = 30, seeds[i])
  print(i)

  if(is.list(tmp)){
    ls.save[[i]] <-tmp
    ls.converge[i] <- 1
  }else{
    ls.save[[i]] <- NA
    ls.converge[i] <- 0
  }
}
# # # #
save(ls.save,file = 'results/HCR/MSE_A_HCR.Rdata')

# ### Loop MSE's with different errors in future survey and recruitment
ls.save <- list()
ls.converge <- matrix(0, nruns)
#
for (i in 1:nruns){
  tmp <- run_multiple_MSEs(simyears = simyears, seeds[i],
                           TAC = 2, df =df)
  #tmp <- run_multiple_MSEs(simyears = 30, seeds[i])
  print(i)
  if(is.list(tmp)){
    ls.save[[i]] <-tmp
    ls.converge[i] <- 1
  }else{
    ls.save[[i]] <- NA
    ls.converge[i] <- 0
  }


}
# # # #
save(ls.save,file = 'results/HCR/MSE_B_JMC.Rdata')

ls.save <- list()
ls.converge <- matrix(0, nruns)

for (i in 1:nruns){
  tmp <- run_multiple_MSEs(simyears = simyears, seeds[i],
                           TAC = 3, df =df)
  #tmp <- run_multiple_MSEs(simyears = 30, seeds[i])
  print(i)
  #tmp <- run_multiple_MSEs(simyears = 30, seeds[i])
  if(is.list(tmp)){
    ls.save[[i]] <-tmp
    ls.converge[i] <- 1
  }else{
    ls.save[[i]] <- NA
    ls.converge[i] <- 0
  }



}
# # # #
save(ls.save,file = 'results/HCR/MSE_C_realized.Rdata')


ls.save <- list()
ls.converge <- matrix(0, nruns)

for (i in 1:nruns){
  tmp <- run_multiple_MSEs(simyears = simyears, seeds[i],
                           TAC = 4, df =df)
  #tmp <- run_multiple_MSEs(simyears = 30, seeds[i])
  print(i)
  #tmp <- run_multiple_MSEs(simyears = 30, seeds[i])
  if(is.list(tmp)){
    ls.save[[i]] <-tmp
    ls.converge[i] <- 1
  }else{
    ls.save[[i]] <- NA
    ls.converge[i] <- 0
  }



}
# # # #
save(ls.save,file = 'results/HCR/MSE_D_Floor50.Rdata')


