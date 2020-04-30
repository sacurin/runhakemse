library(PacifichakeMSE)

run_mse_hcr(ss_extdata_dir = "SS32018",
            nruns = 2,
            simyears = 3,
            fns = c("MSE_A_HCR",
                    "MSE_B_JMC",
                    "MSE_C_realized",
                    "MSE_D_Floor50"),
            om_params_seed = 12345,
            results_root_dir = "results",
            results_dir = "hcr",
            nseason = 4,
            nspace = 2,
            bfuture = 0.5)
