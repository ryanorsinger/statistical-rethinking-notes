# Goal: Install rstan, cmdstan, and rethinking in order to work through Rethinking Statistics.

## Computing Environment
- MacOS Monterrey running on M1 chip
- MacOS Big Sur running on an Intel chip
- Existing dependencies:
    - Installed XCode command line tools with `xcode-select --install`. 
    - I installed R, RStudio, and could install and run other R packages.

## Problem:
- I felt a little lost in the order and detail of the directions from https://github.com/rmcelreath/rethinking/ and https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started and experienced a few false starts.

## Solution:

### 1. Install `rstan`

I ran `install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))`

After that finished, running `library("rstan")` showed no errors.

So I ran `example(stan_model, package = "rstan", run.dontrun = TRUE)` and this looked good.

No errors, so I restarted r (might not be necessary)

### 2. Install `cmdstanr`

As per https://mc-stan.org/cmdstanr/ and https://github.com/rmcelreath/rethinking/

- I ran `install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))`
- Then I ran `cmdstanr::install_cmdstan()`

### 3. Install `rethinking`
`install.packages(c("coda","mvtnorm","devtools","loo","dagitty","shape"))`
`devtools::install_github("rmcelreath/rethinking")`

### 4. Testing

Finally, I ran the following code from Chapter 2 and it produced the appropriate output.

```
library(rethinking)
globe.qa <- quap(
    alist(
        W ~ dbinom( W+L ,p) ,  # binomial likelihood
        p ~ dunif(0,1)     # uniform prior
), data=list(W=6,L=3) )

# display summary of quadratic approximation
precis( globe.qa )
```

produced the following output.

```
  mean   sd 5.5% 94.5%
p 0.67 0.16 0.42  0.92
```


May your installs be smooth and troublefree!