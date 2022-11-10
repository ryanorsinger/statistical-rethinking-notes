library(tidyverse)
library(rethinking)


# 2 kinds of variables
# data is one kind of variable 
# and our parameters are another. Parameters are the unknown
# For each variable, we define it in terms of other variables or probability distributions
# These definitions make it possible to learn about associations between variables
# The combination of variables and their probability distributions defines a JOINT GENERATIVE MODEL 
# that can be used both to simulate hypothetical observations as well as analyze real ones

# y_i ~ Normal(mu_i, sigma)
# m_i = Bx_i
# B ~ Normal(0, 10)
# sigma ~ Exponential(1)
# x_i ~ Normal(0, 1)

# Let's revisit the binomial model of the globe tossing
w <- 6; n <- 9
p_grid <- seq(from=0, to=1, length.out=100)
posterior <- dbinom(w, n, p_grid) * dunif(p_grid, 0, 1)
posterior <- posterior / sum(posterior)


data(Howell1)
d <- Howell1
d %>% head()

# structure function
str(d)
d %>% str()

# concise parameter estimate information for an existing model
# OMG! Sparkling histogram!!
precis(d)

# Extract the height column from the d dataframe
d$height

d[["height"]]


# Setup adults dataframe
d2 <- d[d$age >= 18, ]


dens(d2$height)

# plot the priors
curve(dnorm(x, 178, 20), from=100, to=250)
curve(dunif(x, 0, 50), from=-10, to=60)

# Let's set up our priors.
# Author's height is 178cm and the variance is pretty large

sample_mu <- rnorm(1e4, 178, 20)
sample_sigma <- runif(1e4, 0, 50)
prior_h <- rnorm(1e4, sample_mu, sample_sigma)
dens(prior_h)

# sample_mu <- rnorm( 1e4 , 178 , 100 )
# prior_h <- rnorm( 1e4 , sample_mu , sample_sigma )
# dens( prior_h )





mu.list <- seq( from=150, to=160 , length.out=100 )

sigma.list <- seq( from=7 , to=9 , length.out=100 )

post <- expand.grid( mu=mu.list , sigma=sigma.list )

post$LL <- sapply( 1:nrow(post) , function(i) sum(
  dnorm( d2$height , post$mu[i] , post$sigma[i] , log=TRUE ) ) )

post$prod <- post$LL + dnorm( post$mu , 178 , 20 , TRUE ) +
  dunif( post$sigma , 0 , 50 , TRUE )

post$prob <- exp( post$prod - max(post$prod) )


post$prob

contour_xyz(post$mu, post$sigma, post$prob)

# We now have a posterior distribution of mu and sigma?
image_xyz(post$mu, post$sigma, post$prob)

sample.rows <- sample( 1:nrow(post) , size=1e4 , replace=TRUE ,
                       prob=post$prob )
sample.mu <- post$mu[ sample.rows ]
sample.sigma <- post$sigma[ sample.rows ]

plot( sample.mu , sample.sigma , cex=0.5 , pch=16 , col=col.alpha(rangi2,0.1) )

# Marginal posterior densities
# "Marginal" means "Averaging over the other parameters
dens(sample.mu)
dens(sample.sigma)

PI(sample.mu)
PI(sample.sigma)


d3 <- sample(d2$height, size=20)
mu.list <- seq( from=150, to=170 , length.out=200 )
sigma.list <- seq( from=4 , to=20 , length.out=200 )
post2 <- expand.grid( mu=mu.list , sigma=sigma.list )
post2$LL <- sapply( 1:nrow(post2) , function(i)
  sum( dnorm( d3 , mean=post2$mu[i] , sd=post2$sigma[i], log=TRUE ) ) )

post2$prod <- post2$LL + dnorm( post2$mu , 178 , 20 , TRUE ) +
  dunif( post2$sigma , 0 , 50 , TRUE )
post2$prob <- exp( post2$prod - max(post2$prod) )
sample2.rows <- sample( 1:nrow(post2) , size=1e4 , replace=TRUE ,
                        prob=post2$prob )
sample2.mu <- post2$mu[ sample2.rows ]
sample2.sigma <- post2$sigma[ sample2.rows ]
plot( sample2.mu , sample2.sigma , cex=0.5 ,
      col=col.alpha(rangi2,0.1) ,
      xlab="mu" , ylab="sigma" , pch=16 )

dens(sample2.sigma, norm.comp=TRUE)
