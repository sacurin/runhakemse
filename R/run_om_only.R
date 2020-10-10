load_all("../pacifichakemse/")


#ss_model_output_dir <- "C:/tmp/PacifichakeMSE/inst/extdata/SS32018"
ss_model_output_dir <- "C:/github/pacific-hake/hake-assessment/models/2020.01.09_DMprior_base"

ss_model_data_csv_dir <- "C:/github/pacific-hake/hake-assessment/data"
ss_model_raw <- load_ss_model_from_rds(ss_model_output_dir,
                                       ss_model_data_csv_dir,
                                       load_extra_mcmc = FALSE)
ss_model <- load_ss_model_data(ss_model_raw)
om <- load_data_om(ss_model, n_sim_yrs = 5)
om_0 <- run_om(om, verbose = FALSE)
#om$selectivity_change <- 1
#om_1 <- run_om(om, verbose = FALSE)
#om$selectivity_change <- 2
#om_2 <- run_om(om, verbose = FALSE)
cat(green(symbol$tick),
    green("Ran OM successfully\n"))


