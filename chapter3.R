
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

