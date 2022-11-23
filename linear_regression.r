# Think of Linear Regression like the Epicycle model
# It can apply in a lot of places where it's not always appropriate
# But the mechanics of the model won't know or not if it makes sense
# Linear regressions are models that learn the mean/variance of some measurement using an additive combination
library(rethinking)

# General Recipe for modeling:
# First, recognize a set of variables we with to understand
# Some variables are observable, these are the data
# Some are unobservable things like rates/averages. These are parameters
# Second:
# For each variable, we define it in terms of other variables or in terms of a probability distribution
# Theswe associations make it possible to learn about associations between variables
# Third, the combination of variables and their probability distributions define a Joint-Generative Model.
# We use joint-generative models to simulate hypothetical observations as well as analyze real ones

# Globe Model
# W ~ Binomial(N, p)
# p ~ Uniform(0, 1)
# The count W is distributed binomially, with sample size N, probability p
# The prior for p is assumed to be uniform between zero and 1.

w <- 6; n <- 9
p_grid <- seq(from=0, to=1, length.out=100)
posterior <- dbinom(w, n, p_grid) * dunif(p_grid, 0, 1)
posterior <- posterior / sum(posterior)
posterior
plot(posterior)

# let's work with height data
# and use quap!

library(rethinking)
data(Howell1)
d <- Howell1
d2 <- d[ d$age >= 18 , ]

flist <- alist(
  height ~ dnorm( mu , sigma ) ,
  mu ~ dnorm(178 , 20 ) ,
  sigma ~ dunif( 4 , 50 )
)

flist

m4.1 <- quap( flist , data=d2 )
precis(m4.1)


