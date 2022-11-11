# Chapter 4 Notes

Ptolemy rocked an extremely mathematical model of the motion of planets. It was based on epicycles and with enough epicycles in the right places, the model could make very accurate predictions.

All models are an approximation of some reality.
All models are incorrect.

Lesson is: our statistical models can have predictive power, even without having explanatory power, even with being based on a correct process model: like Ptolemy's epicycles.

If you know the correct processes for the solar system, then using epicycles seems crazy, but the ancients came upon this generalizable process.

Given enough circles, these epicycles can become a Foiurier series, a way of decomposing a periodic function into a series of sine and cosine functions.

"Linear regression is the geocentric model of applied statistics" - McElreath.
Linear regression: learning about the mean and variance of some measurement using additive combinations of other moeasurements. 

Linear regression is simple, flexible, and commonplace. We'll approach as a Bayesian procedure in this text, using a Gaussian distribution to describe the model's uncertainty about some measure.


Where does normality come from, anyways?

"Any process that adds together random values from the same distribution converges to a normal" - McElreath

But why does addition result in a bell curve of sums?

# Normal distributions come from arise from summing random fluctuations

Small effects that multiply together are approximately additive, so they tend to stabilize to normal distributions.

But wait, there's more! Even if we're multiplying larger numbers together and they don't produce a Gaussian distribution, they DO tend to produce Gaussian distributions on a log scale!

What's the connection to the Central Limit Theorum? I wonder...

## So How Do We Use Gaussian Distributions?
- We'll use the Gaussian distribution as a skeleton for our hypotheses, building up models of measurements as aggregations of normal distributions.
- Justifications for Gaussian distribution fall into both ontological and epistemological categories.
- We see Gaussian distributions everywhere in Nature. They're not perfect, but they're pervasive
- Measurement errors, variations in growth, velocities of molecules, and more all tend towards Gaussian distributions.
- Many processes, at their heart, add together fluctuations. And when we add together fluctuations, the Gaussian distribution arises! (How I learned to stop worrying and love the Gaussian!)
- Gaussian distribution based models, however, can't reliably identify micro-process. 
- Other patterns commonly found in Nature: exponential, gamma, Poisson
- Gaussian distribution is from a family of natural distributions called the "Exponential Family"
- Gaussian represents a particular state of ignorance. When all we know is the mean and variance, then Gaussian distribution arises as the most consistent with our assumptions.
- "Most natural expression of our state of ignorance"
    - If we assume that a measure has finite variance, then the Gaussian distribution can be realized in a large number of ways w/o introducting other assumptions.
- Gaussian = least surprising, least informative assumption to make.
- If you choose to use a different distribution, then it means you know something else that you should tell your golem about.
- "Maximum Entropy" and "Information Theory"
- Gaussian is good unless we know something else about the process, like how financial results have fat tails in the long term, or how trends in warfare are prone to heavy tails. (Black Swan events, for example)


