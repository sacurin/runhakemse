#library(pacifichakemse)
load_all("../pacifichakemse")
library(here)

results_root_dir <- here("results")
results_dir <- file.path(results_root_dir, "selectivity")

ss_model_yr <- 2018
ss_model_output_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                 "extdata", paste0("SS3_", ss_model_yr))
ss_model_data_csv_dir <- file.path(system.file(package = "pacifichakemse", mustWork = TRUE),
                                   "extdata", "csv-data")

fns <- c("MSE_sel1",
         "MSE_sel2",
         "MSE_sel3")

plotnames <- c("Base scenario",
               "US small \nselectivity",
               paste0(ss_model_yr, " selectivity"))

# List of vectors (of two) of the same length as the number of scenarios, one vector for each scenario.
# For each vector of two e.g. c(a, b): the new catch in the OM is c_new * b + a
# If instead of a 2-element vector, a single value is given, the expanded catch in the OM will be
# c_new * 0.5 unless below catch_floor in which case it will be c_new = catch_floor.
# To apply no TAC, use c(0, 1).
# In any event, if the calculation is greater than c_new, c_new will be used instead
tacs <- list(c(139482.707564733, 0.378286338688197), # JMC values (see run_MSE_HCR.R)
             c(139482.707564733, 0.378286338688197),
             c(139482.707564733, 0.378286338688197))

# A vector with one element for each scenario, which is additional proportion of the stock to be
# moved from space 2 to space 1 (into Canada). If a single value instead of a vector, that value
# will be used for all scenarios.
movein_increases <- 0
# A vector with one element for each scenario, which is additional proportion of the stock to be
# moved from space 1 to space 2 (out of Canada). If a single value instead of a vector, that value
# will be used for all scenarios.
moveout_decreases <- 0

# A vector with one element for each scenario, or a single value to use for all scenarios
sel_changes <- c(0, 1, 2)

run_mses(ss_model_output_dir = ss_model_output_dir,
         ss_model_data_csv_dir = ss_model_data_csv_dir,
         load_extra_mcmc = FALSE,
         overwrite_ss_rds = FALSE,
         n_runs = 1,
         n_sim_yrs = 5,
         sel_change_yr = 1991,
         fns = fns,
         plot_names = plotnames,
         tacs = tacs,
         c_increases = movein_increases,
         m_increases = moveout_decreases,
         sel_changes = sel_changes,
         f_sim = 0.2, # not used as of Oct 9, 2020
         random_seed = 12345,
         results_root_dir = results_root_dir,
         results_dir = results_dir,
         ss_mcmc_quants = c(0.025, 0.5, 0.975),
         # Arguments to load_data_seasons(), for OM setup
         n_season = 4,
         season_names = c("Season1", "Season2", "Season3", "Season4"),
         n_space = 2,
         space_names = c("Canada", "US"),
         ages = 0:20,
         age_names = paste("age", 0:20),
         move_max_init = 0.35,
         move_fifty_init = 6,
         n_surveys = 2,
         rdev_sd = 1.4,
         b_future = 0.5,
         move_out = 0.85,
         move_south = 0.05,
         move_init = NULL,
         move_slope = 0.9,
         ages_no_move = 0:1,
         s_min = 1,
         s_max = 6,
         s_min_survey = 2,
         s_max_survey = 6,
         f_space = c(0.2612, 0.7388),
         log_phi_survey = log(11.46),
         catch_floor = 180000,
         pope_mul = 0.5,
         verbose = FALSE)

# df_future <- load_data_seasons(movemaxinit = 0.35,
#                                movefiftyinit = 6,
#                                yr_future = 5)
# dfs_future <- rep(list(df_future), length(fns))
# dfs_future <- map2(dfs_future, 0:(length(dfs_future) - 1), ~{
#   .x$selectivity_change <- .y
#   .x
# })
# sim_datas <- map(dfs_future, ~{
#   run.agebased.true.catch(.x)
# })
# yrs <- df_future$years
# sim_datas_desc <- c("Base scenario",
#                     "Low US selectivity",
#                     paste0(max(yrs), " selectivity"))
#
# # #------------------------------------------------------------------------------
# # Plot the three scenarios' selectivities
# df_plot <- map2(sim_datas, sim_datas_desc, ~{
#   Fsel_dims <- attributes(.x$Fsel)$dim
#   sel_can <- .x$Fsel[, Fsel_dims[2], 1]
#   sel_usa <- .x$Fsel[, Fsel_dims[2], 2]
#   tibble(selectivity = c(sel_can,
#                          sel_usa),
#          country = c(rep("CAN", length(sel_can)),
#                      rep("USA", length(sel_usa))),
#          age = rep(attributes(.x$Fsel[,,1])$dimnames$age, 2),
#          run = .y)
# }) %>%
#   bind_rows() %>%
#   mutate(run = factor(run),
#          age = as.numeric(age))
#
# p1 <- ggplot(data = df_plot, aes(x = age, y = selectivity, color = country)) +
#   theme_classic() +
#   geom_line(size = 1.2) +
#   facet_wrap(~run) +
#   scale_x_continuous(limit = c(0, df_future$age_maxage)) +
#   scale_color_manual(values = c("darkred", "blue4"))
# p1
#
# png(here(results_root_dir, results_dir, "Selectivity_difference.png"),
#          width = 16, height = 8, res = 400, unit = "cm")
# p1
# dev.off()
#
# #write.csv(seeds,file = 'results/Selectivity/seeds.csv', row.names = FALSE) # Save the seeds
