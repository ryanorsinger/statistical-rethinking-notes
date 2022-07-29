"Bayesian inference is really just counting and comparing of possibilities."

## Mind the two worlds:
- Small World is the world of the model (the map)
- Large Word is the world of reality (the terrain)
- The terrain ain't the map. Never will be. All models are approximations of reality. Even a fabulous wizbang detailed map is always a map and not the terrain itself.

## Counting possibilities


Updating:
1. When we have previous information suggesting there are $W_prior$ ways for a conjecture to produce a previous observation $D_prior$ and
2. We acquire new observations $D_new$ that the same conjecture can produce in $W_new$ ways, then
3. The number of ways the conjecture can account for both $D_prior$ and $D_new$ is the product $W_prior * W_new$.

When we're updating, we're updating our counts based on new data and the data produced from our conjectures

## Vocabulary
- A conjectured portion of observations, `p`, is usually called a `parameter` value. It's a way of indexing possible explanations of the data.
- The relative number of ways that a value `p` can produce the data is usually called the `likelihood`. The likelihood is derived by enumerating all the possible data sequences that could have happened and then eliminating those sequences inconsistent with the data.
- The prior plausability of any specific value `p` is usually called the `prior probability`.
- The new, updated plausability of any specific `p` is usually called the `posterior probability`.

$$ plausability of p after D_new = frac{ways p can produce D_new * prior plausability p}{sum of products} $$