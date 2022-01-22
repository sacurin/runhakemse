set.seed(1234)

rdev_sd=1.4

r_devs <- rnorm(n = 30,
                mean = 0,
                sd = exp(rdev_sd))

plot(r_devs, type='l',lty=1)

set.seed(1234)

rdev_sd=1.

r_devs <- rnorm(n = 30,
                mean = 0,
                sd = exp(rdev_sd))


lines(r_devs, col='red', lty=1)

exp(1)
exp(1.4)
exp(0.8)
2.7/4
