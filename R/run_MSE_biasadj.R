library(PacifichakeMSE)
library(purrr)
library(here)
library(r4ss)
.seed <- 12345
results_dir <- "bias_adjustment"
nruns <- 2
simyears <- 3

mod <- SS_output(system.file("extdata/SS32018/",
                             package = "PacifichakeMSE",
                             mustWork = TRUE),
                 printstats = FALSE,
                 verbose = FALSE)

seeds <- floor(runif(n = nruns, min = 1, max = 1e6))
fns <- c("MSErun_move_nofishing_nobiasadj.rds",
         "MSErun_move_nofishing_biasadj.rds",
         "MSErun_move_nofishing_biasadj_med.rds")
if(!dir.exists(here("results"))){
  dir.create(here("results"))
}
if(!dir.exists(here("results", results_dir))){
  dir.create(here("results", results_dir))
}

# Prepare data for operating model
dfs <- list()
dfs[[1]] <- load_data_seasons(nseason = 4,
                              nspace = 2)
dfs[[2]] <- load_data_seasons(nseason = 4,
                              nspace = 2,
                              bfuture = 0.87)
dfs[[3]] <- load_data_seasons(nseason = 4,
                              nspace = 2,
                              bfuture = 0.5)

# Loop MSEs with different errors in future survey and recruitment
map2(fns, dfs, ~{
  ls_save <- map(1:nruns, function(run = .x, ...){
    tmp <- run_multiple_OMs(simyears = simyears,
                            seed = seeds[run],
                            df = .y,
                            Catchin = 0)
    ifelse(is.list(tmp), tmp, NA)
  }, ...)
  saveRDS(ls_save, file = here("results", results_dir, .x))
})
