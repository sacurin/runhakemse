library(PacifichakeMSE)
library(dplyr)
library(ggplot2)
library(purrr)

results_root_dir <- here("results")
results_dir <- here("results", "selectivity")
fns <- c("MSE_sel1.rds",
         "MSE_sel2.rds",
         "MSE_sel3.rds")

run_mses(ss_extdata_dir = "SS32018",
         nruns = 2,
         simyears = 3,
         fns = fns,
         tacs = 2,
         cincreases = 0,
         mincreases = 0,
         sel_changes = 0:2,
         om_params_seed = 12345,
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         nseason = 4,
         nspace = 2,
         bfuture = 0.5)

df_future <- load_data_seasons(movemaxinit = 0.35,
                               movefiftyinit = 6,
                               yr_future = 5)
dfs_future <- rep(list(df_future), length(fns))
dfs_future <- map2(dfs_future, 0:(length(dfs_future) - 1), ~{
  .x$selectivity_change <- .y
  .x
})
sim_datas <- map(dfs_future, ~{
  run.agebased.true.catch(.x)
})
yrs <- df_future$years
sim_datas_desc <- c("Base scenario",
                    "Low US selectivity",
                    paste0(max(yrs), " selectivity"))

#------------------------------------------------------------------------------
# Plot the three scenarios' selectivities
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

png(here(results_root_dir, results_dir, "Selectivity_difference.png"),
         width = 16, height = 8, res = 400, unit = "cm")
p1
dev.off()

#write.csv(seeds,file = 'results/Selectivity/seeds.csv', row.names = FALSE) # Save the seeds
