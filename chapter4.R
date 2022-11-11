library(rethinking)

# Random Walk
pos <- replicate(1000, sum( runif(16, -1, 1)))

# Normal distributions come from arise from summing random fluctuations
hist(pos)

# Normal distributions come from arise from summing random fluctuations
plot(density(pos))

# So this binomial outcome has a uniform distribution.
# Completely fair "coin"
# But the summations become normal

# Produces a random growth rate
prod(1 + runif(12, 0, 0.1))

# Normal distributions come from arise from summing random fluctuations
growth <- replicate(1e4, prod(1 + runif(12, 0, 0.1)))
dens(growth, norm.comp=TRUE)

# Notice how this produces something not-so normal
big <- replicate(1e4, prod(1 + runif(12, 0, 0.5)))
hist(big)

# Much smaller numbers produce a normal distribution when multiplied 
# b/c it's so much like summing, due to their size
small <- replicate(1e4, prod(1 + runif(12, 0, 0.1)))
hist(small)

# But wait, there's more! 
# Even if we're multiplying larger numbers together and they don't produce a Gaussian distribution, they DO tend to produce Gaussian distributions on a log scale!
# TADA!
log.big <- replicate(1e4, log(prod(1 + runif(12, 0, 0.5))))
hist(log.big)










library(rethinking)
data(Howell1)
d <- Howell1
library(tidyverse)

head(d)

d %>% head()

d %>% 
  ggplot(aes(x=weight, 
             y=height,
             color=(age >=18))) + 
  geom_point()

# Goal is to model the height (w/o mention of the weight)


d2 <-
  d %>% 
  filter(age >= 18)

d2

# "Prior predictive analysis", proir predictive checks (regenerate the data to see if it makes sense to see if our assumptions make sense)
sample_mu <-rnorm(1e4, 178, 20)
sample_sigma <- runif(1e4, 0, 50)
prior_h <- rnorm(1e4, sample_mu, sample_sigma)
dens(prior_h)

?quap

# There's list(4, 5) and list(x=4, y=5)
# what is alist? a list of expressions, lazy/unevaluated expressions in symbolic form

flist <- alist(
  height ~ dnorm( mu , sigma ) ,
  mu ~ dnorm( 178, 20 ) ,
  sigma ~ dunif( 0, 50)
)

# Quadratic approximation of this data w/ this model
m4.1 <- quap(flist, data=d2)
m4.1

precis(m4.1)

# What quap creates is an approximation of the posterior, by (multivariate) normal distributions

# We want to write a model for how height is dependent on weight
plot(d2$height ~ d2$weight)

# Height is normally distributed and is linearly dependent on the weight, it seems
# The expectation for the height with heavier weight is higher height
