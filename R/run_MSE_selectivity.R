library(PacifichakeMSE)
library(ggplot2)
library(purrr)
library(here)
library(r4ss)
.seed <- 12345
results_dir <- "selectivity"
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
df_future <- load_data_seasons(movemaxinit = 0.35,
                               movefiftyinit = 6,
                               yr_future = 5)

fns <- c("MSE_sel1.rds",
         "MSE_sel2.rds",
         "MSE_sel3.rds")
dfs <- rep(list(df), length(fns))
dfs_future <- rep(list(df_future), length(fns))
dfs_future <- map2(dfs_future, 0:(length(dfs_future) - 1), ~{
  .x$selectivity_change <- .y
  .x
})
sim_datas <- map(dfs_future, ~{
  run.agebased.true.catch(.x)
})
sim_datas_desc <- c("Base scenario",
                    "Low US selectivity",
                    paste0(max(yrs), " selectivity"))
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
                             TAC = 2,
                             df = .y)
    ifelse(is.list(tmp), tmp, NA)
  }, ...)
  saveRDS(ls_save, file = here("results", results_dir, .x))
})

#------------------------------------------------------------------------------
# Plot the scenarios' selectivities
df_plot <- map2(sim_datas, sim_datas_desc, ~{
  Fsel_dims <- attributes(.x$Fsel)$dim
  sel_can <- .x$Fsel[, Fsel_dims[2], 1]
  sel_usa <- .x$Fsel[, Fsel_dims[2], 2]
  tibble(selectivity = c(sel_can,
                         sel_usa),
         country = c(rep("CAN", length(sel_can)),
                     rep("USA", length(sel_usa))),
         age = rep(attributes(.x$Fsel[,,1])$dimnames$age, 2),
         run = .y)
}) %>%
  bind_rows() %>%
  mutate(run = factor(run),
         age = as.numeric(age))

p1 <- ggplot(data = df_plot, aes(x = age, y = selectivity, color = country)) +
  theme_classic() +
  geom_line(size = 1.2) +
  facet_wrap(~run) +
  scale_x_continuous(limit = c(0, df_future$age_maxage)) +
  scale_color_manual(values = c("darkred", "blue4"))
p1

png(here("results", results_dir, "Selectivity_difference.png"),
         width = 16, height = 8, res = 400, unit = "cm")
p1
dev.off()

#write.csv(seeds,file = 'results/Selectivity/seeds.csv', row.names = FALSE) # Save the seeds
