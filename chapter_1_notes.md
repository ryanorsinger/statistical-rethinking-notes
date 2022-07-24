When we need inference, what do we do instead of play "pick the statistical test"?

What's the "answer"?
- "Rethinking" statistics
- Deductive falsification is a place a lot of folks start (popular Popperism), but is impossible in all contexts b/c
    - Hypotheses are not models. The relationship between models and hypotheses uis complex. Many models correspond to the same hypothesis. Many hypotheses correspond to the same model, too.
    - Measurement matters. Even if we think the data falsify a model, another observer might debate our methods and measures.

- The scientific method cannot be reduced to a statistical procedure, so our stats methods shouldn't predent that's the case.
- Science is a "hot mess"
- By their nature, all models are false, so what does it even mean to falsify a model?

## How do we get a statistica model from a ausal model?
- Derive the expected frequency distribution of some quantity (a statistic) from the causal model.
- See pg. 6, figure 1.2
- Takeaways:
    - Any given statistical model M may correspond to more than one process model P
    - Any given hypothesis H may correspond to more than one process model P
    - Any given statistical model M may correspond to more than one hypothesis H
- One problem (among many) is testing frequency distributions against power law expectations
- So what can be done? If we have multiple process models, we can do more: at the very least, explicitly compare predictions from more than one model.

## Now we know
- Distributions like normal, binomial, Poisson, and others all belong to a family of distributions called the "Exponential Family". And all of these in the family are "maximum entropy" distributions. 
- Practical approach: one can no more infer evolutionary process from a power law than one can infer developmental process from the fact that height is normally distributed. And this should "make us humble about what typical regression models (the meat of this book) can teach us about mechanistic process". 
- The maximum entropy nature of these distributions mean we can use them usefully, even if we can't identify the underlying process.
- Popper himself saw science as broader than simply falsification.

## Example hypotheses
- "All swans are white" is falsifiable by a single non-white swan, but it's not proveable by any number of white swans.
- But we find lots of edges. what about "Our experiment shows that neutrinos travel faster than light"? The particle is consumed by the measurement, so measurement is tricky. And the measurement is a statistical estimate, not an actual concrete measure. It turned out that, in this case, there was a poorly attached cable. 
- Ask if the "falsification" is real or spurious?
- But what about when we have a continuous hypothesis like our H_o is "80% of swans are white" or H_o is "Black swans are rare"
