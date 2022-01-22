df<-out[[1]]

yr_start=2018
ssb.plot=rowSums(df$ssb_initial)/sum(df$ssb_0)
v.plot=rowSums(df$v_save[,,1])
catch=(df$catch)

H=catch[yr_start-1966:length(v.plot)]/v.plot[yr_start-1966:length(v.plot)]

plot(ssb.plot[yr_start-1966:length(v.plot)],catch[yr_start-1966:length(v.plot)], type='l')
plot(v.plot[yr_start-1966:length(v.plot)],catch[yr_start-1966:length(v.plot)])
plot(ssb.plot[yr_start-1966:length(v.plot)],v.plot[yr_start-1966:length(v.plot)], type='l')
plot(v.plot[yr_start-1966:length(v.plot)],H, type='l')
plot(ssb.plot[yr_start-1966:length(v.plot)],H, type='l')





plot_tac_est_vs_real <- function(df){
  ggplot(data = df$tac_ssb, aes(x = ssb * 1e-6, y = tac * 1e-6)) +
    geom_line() +
    scale_y_continuous("TAC (million tonnes)") +
    scale_x_continuous("SSB (million tonnes)") +
    theme_classic()
}










p_sel1 <- df$parameters$p_sel_fish %>%
  filter(space == 1)
p_sel2 <- df$parameters$p_sel_fish %>%
  filter(space == 2)
p_sel<- df$parameters$p_sel_fish

f_sel1 <- get_select(df$ages,
                     p_sel1,
                     df$s_min,
                     df$s_max)
f_sel2 <- get_select(df$ages,
                     p_sel2,
                     df$s_min,
                     df$s_max)
f_sel<- get_select(df$ages,
                   p_sel,
                   df$s_min,
                   df$s_max)



