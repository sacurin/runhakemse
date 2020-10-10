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
om$selectivity_change <- 1
om_1 <- run_om(om, verbose = FALSE)
om$selectivity_change <- 2
om_2 <- run_om(om, verbose = FALSE)
cat(green(symbol$tick),
    green("Ran OM successfully\n"))

# Check the three OMs - final year selectivity at age
offset <- 0 # How many years prior to the final year
yr_ind <- dim(om_0$f_sel_save)[2] - offset
yr <- om_0$m_yr - offset
d <- data.frame(sel = c(om_0$f_sel_save[,yr_ind,1], om_1$f_sel_save[,yr_ind,1], om_2$f_sel_save[,yr_ind,1],
                        om_0$f_sel_save[,yr_ind,2], om_1$f_sel_save[,yr_ind,2], om_2$f_sel_save[,yr_ind,2]),
                country = rep(c("CAN", "USA"), each = 3 * om_0$n_age),
                age = rep(om_0$ages, 6),
                run = rep(rep(c("Base scenario",
                                "Low US selectivity",
                                paste0(yr, " selectivity")),
                              each = om_0$n_age), 2)) %>%
  as_tibble()
d$run <- factor(d$run, levels = c("Base scenario",
                                  "Low US selectivity",
                                  paste0(yr, " selectivity")))

p <- ggplot(data = d,
            aes(x = age, y = sel, color = country)) +
  theme_classic() +
  geom_line(size = 1.2) +
  facet_wrap(~run) +
  scale_x_continuous(limit = c(0, om_0$age_max_age)) +
  scale_color_manual(values = c("darkred","blue4"))

print(p)