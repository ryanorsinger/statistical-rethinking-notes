
# Introducing the Vampire Blood Test!~

# Probability of a positive test result given someone is a vampire
Pr_positive_vampire <- 0.95

# Probability of a postiive test result given someone is a mortal
# False positive
Pr_positive_mortal <- 0.01

# Population probability of being a vampire
Pr_vampire <- 0.001

Pr_mortal <- 1 - Pr_vampire

# Probability of seeing a positive test
Pr_positive <- Pr_positive_vampire * Pr_vampire +  Pr_positive_mortal * Pr_mortal

# Bayes Rule for Pr(vampire | positive test)
Pr_vampire_positive <- Pr_positive_vampire * Pr_vampire / Pr_positive

# About 8.7% chance of someone being a vampire given a positive test
# Watch out for Professor Von Helsing's false positives!
Pr_vampire_positive



## Another approach could be a Mirror test 
# Assuming all vampires cast no reflection, the accuracy is 100%
# In this case, Pr(vampire | no_reflection) == 100%, since there's zero false positives or false negatives w/ the mirror

## We could do a garlic test for vampirisim, too
# Some strong vampires may be able to tolerate garlic
# Maybe 5% of mortals are reactive to garlic
Pr_positive_vampire <- 0.9 # 10% of vampires can stand garlic
Pr_positive_mortal <- 0.05 # 5% of mortals cannot stand garlic, so we see a positive

# Same population probability of vampire vs. mortal

# Probability of seeing a positive garlic test
Pr_positive <- Pr_positive_vampire * Pr_vampire +  Pr_positive_mortal * Pr_mortal
Pr_vampire_positive <- Pr_positive_vampire * Pr_vampire / Pr_positive

# Probability of being a vampire given a positive garlic test = 1.7% 
Pr_vampire_positive

## QUESTION: What if we stack both tests together? The blood test + the garlic test?


## Now let's talk about counts instead of frequencies. The Count!
# In a population of 100,000 people, 100 are actually vampires
# Of the 100 who are vampires, 95 of them will test positive for vampirism (with the first blood test)
# Of the 99,900 mortals, 999 will test positive for vampirism
# Pr(vampire | positive) = 95 / 1094 = 0.87

# Chapter 3 is all about sampling from probability distributions to produce counts.
# Since the posterior distribution is a probability distribution, we can draw samples from it
# The sampled events from a posterior distribution are PARAMETER VALUES
# Working with samples transforms the problem from claculus into a problem in data summary, into a frequency format problem.

# An integral in the Bayesian context is the total probability of in some interval
# Once we have samples from the probability distribution, it's a matter of counting values in the interval
# This is an empirical approach on the posterior, allowing scientists to ask/answer more questions about the model
# Punchline: work with samples from the posterior distribution instead of probabilities and integrals directly
# Many computational methods (including MCMC) only produce samples, so there we go!


# Sampling from a grid-approximate posterior
# Let's revisit our globe toss
# The posterior here means the probability of p conditional on the data 
# posterior = Pr(p | data)

p_grid <- seq(from=0, to=1, length.out=1000)
prob_p <- rep(1, 1000)
prob_data <- dbinom(6, size=9, prob=p_grid)

# unnormalized posterior
posterior <- prob_data * prob_p

# normlized posterior
posterior <- posterior / sum(posterior)

# Now we have the posterior distribution
posterior

# Let's take some samples
samples <- sample(p_grid, prob=posterior, size=1e4, replace=TRUE)
samples

# WE HAVE SAMPLED THE POSTERIOR
plot(samples)

# Pull in the rethinking library
library(rethinking)

# Now we have a density estimate
dens(samples)

# How to plot out the samples w/o the helper
# TODO: sort out how to plot the density function w/o the rethinking function
library(ggplot2)



# Notice the density estimate is very similar to the ideal posterior we computed
# As we draw more samples, the density estimate gets closer to the ideal posterior

# Once the model produces a posterior distribution, the model's is done
# But now our work begins!
# We need to summarize and interpret the posterior distribution
# Questions include:
# How much of the posterior probability lies below some parameter value?
# How much posterior probability lies between two parameter values?
# Which parameter value marks the lower 5% of the posterior probability
# Which range of parameter values contains 90% of the prior probability?
# Which prameter value has the highest posterior probability?

# Types of questions can be defined into questions about
# Questions about intervals of defined boundaries
# Questions about the intervals of defined probability mass
# Questions about point estimates.


# Intervals of defined boundaries
# This works when we have a single parameter, but is much more challenging with more parameters
# Grid approximation isn't practical in general, though
sum( posterior [ p_grid < 0.5 ])


sum( samples < 0.5 ) / 1e4
sum( samples < 0.5 ) / 1e5

sum( samples > 0.5 & samples < 0.75) / 1e4

# Intervals of defined mass
# CONFIDENCE INTERVAL Scientific journals often report an interval of deifned mass known as a confidence interval
# An interval of posterior probability, like what we're working with, may be called a CREDIBLE INTERVAL
# We'll use a 3rd term to disambiguiate: COMPATIBILITY INTERVAL, to avoid implications of credibility and confidence.
# Compatibility Interval is the range of parameter values compatible with the model and data
# Compatibility Interval is the range of parameter values compatible with the model and the data
# These posterior intervals report two parameter values that contain a specified amount of posterior probability between them, a probability mass

# Suppose we want to know the boundaries of the lower 80% prior probabilities. 
# we know the interval starts at p=0
# to find out where tit stops, think of samples as data and ask where the 80th percentile is
quantile( samples, 0.8) 

# Find the upper-bound parameter of the first half of the density
quantile( samples, 0.5)

# Find the interval boundaries between the 10th percentile and the 90th percentile
# This is a PI, a Percentile Intervals
# They describe well unless the distribution is super asymetrical
# This finds the middle 80% (middle, evenly)
quantile(samples, c( 0.1 , 0.9 ))


# What if we get 3 waters out of 3 tosses and use a flat, uniform prior?
p_grid  <- seq( from=0, to=1, length.out=1000)
prior <- rep(1, 1000)
likelihood <- dbinom(3, size=3, prob=p_grid)
posterior <- likelihood * prior # non-normalized
posterior <- posterior / sum(posterior) #normalize
samples <- sample( p_grid, size=1e4, replace=TRUE, prob=posterior)

# PI function comes from the rethinking library
# This interval runs like the quantile(samples, c(0.25, 0.75))
quantile(samples, c(0.25, 0.75))
PI(samples, prob=0.5)

# HPDI is the Highest Posterior Density Interval
# This is the narrowest interval containing the specified probability mass
# HPDI is more computationally intensive than PI and has more simulation variance (sensitive to how many samples we draw)
x <- HPDI(samples, prob=0.5)
x

width <- x[2] - x[1]
width

dens(samples)

# Remember that the entire posterior distribution is the Bayesian "estimate"
# History of science shows that "confidence intervals exchibit chronic overconfidence"

# Point Estimates
# 3rd common summary task for the posterior is to produce point estimates, of some kind
# Given the entire posterior distribution, what value should you report?
# Easy sounding question, but difficult to answer...
# Point estmates discard information, however, since the Bayesian parameter estimate is the entire posterior distribution, a function mapping each parameter value onto a plausability value...
p_grid[which.max(posterior)]

chainmode(samples, adj=0.01)

chainmode(samples)

mean(samples)
median(samples)

# But why choose a mean, median, or mode? What's 'best' and why? It depends, right?
# We can work with a Loss Function
# Loss function si a rule that tells us the cost associated with using any particular point estimate.
# Different loss functions imply different point estimates...

# This calculates the weighted average loss, where each loss is weighted by its corresponding posterior probability
sum(posterior * abs(0.5 - p_grid))

loss <- sapply(p_grid , function(d) sum( posterior * abs(d - p_grid)))
loss

plot(loss)
dens(loss)

p_grid[which.min(loss)]

# Try the median of the posterior(samples)
median(samples)

# What's the punchline?
# In order to decide on a point estimate, a single value summary of the posterior distribution
# We need to pick a loss function
# Different loss functions nominate different point estimates, however
# Two most common are:
# absolute loss, which leads to the median, median(samples)
# quadratic loss, (d - p)^2, which leads to the posterior mean, mean(samples)
# If the sample distribution is symmetrical and normal-ish, these 2 loss functions converge on the same point
# For example, with the 6 waters out of 9 tosses, these are basically the same value


