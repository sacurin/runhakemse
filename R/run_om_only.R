load_all("../pacifichakemse/")

# Number of years to simulate in MSE. Only needed here because it is required when
# setting up OM for allocation of arrays in the OM.
n_sim_yrs <- 4
# Number of years to simulate in OM
yr_future <- 5

ss_model_output_dir <- "C:/tmp/PacifichakeMSE/inst/extdata/SS32018"
ss_model_raw <- load_ss_model_from_rds(ss_model_output_dir,
                                       load_extra_mcmc = FALSE)
ss_model <- load_ss_model_data(ss_model_raw,
                               s_yr = 1966,
                               m_yr = 2018)
df <- load_data_om(ss_model,
                   n_sim_yrs,
                   catch_props_space_season = list(c(0.001, 0.188, 0.603, 0.208),
                                                   c(0.000, 0.317, 0.382, 0.302)),
                   yr_future = 0)

yrs_all <- c(df$yrs, (df$yrs[length(df$yrs)] + 1):(df$yrs[length(df$yrs)] + n_sim_yrs))
om_objs <- setup_blank_om_objects(yrs = yrs_all,
                                  ages = df$ages,
                                  max_surv_age = df$age_max_age,
                                  n_space = df$n_space,
                                  n_season = df$n_season)

sim_data <- run_om(df,
                   om_objs,
                   random_seed = 42)
