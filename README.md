<h1 align="center">Regression and Goodness of fit</h1>

### Project Objective
This project is the final submission of my third coursework doing MATH20811 Practical Statistics on Linear Regression. Based on the data provided, the report explores how they may be related linearly, estimating and commenting through tests on the parameters for the model as well the fitted values. The residuals of the estimation is then looked into to examine the plausibility of the assumptions in the regression model through Normal quantile-quantile plot and goodness-of-fit tests, specifically the Kolmogorov-Smirnov (KS) test.

#### -- Project Status: [Completed]

### Methods used
- regression
- hypotheses testing
- goodness-of-fit test

### Technologies
- LateX
- R

## Project Description
The  data used for this project can be obtained from [Analysis of Risk Premium in Motor Insurance](https://github.com/fahimahghazali/Linear-regression-and-goodness-of-fit/blob/main/sweden_ins_data.txt) where the `claims` is the predictor variable denoted by x and the `payment` is the response variable denoted by y. With the n = 63 observations, a simple linear regression is assumed through the scatterplot of x against y and the parameters are estimated using the least squares method. This project is split into two main parts- the linear regression analysis and the goodness-of-fit test on the residuals. 

For the first part, instead of using the built-in `lm` function in R, I have written my own function to obtain said parameters, as well as the fitted values, estimated errors and the residual degrees of freedom. Multiple plots are included in the project for visual representation of the analysis, including the fitted regression line and diagnostic plot of the standardised residuals against the fitted values. An F-test is also done on the mean response to see if it is a constant, letting that be the null hypothesis. 

In the second part of the project, we mainly focus on the standardised residuals of the model. Plots such as diagnostic plots of the standardised residuals against the fitted values and against the predictors, and Normal quantile-quantile plot are constructed to analyse the residuals' normality and other assumptions in the linear regression model. To further investigate it's Normality, a KS test is done and it's empirical cumulative distribution function (cdf) is compared to the cdf of a standard Normal distribution. Finally, sampling distribution of the KS statistic is simulated and the 5% critical value is obtained and compared to the KS statistic obtained earlier.

The final report can be read [here](https://github.com/fahimahghazali/Regression-and-goodness-of-fit/blob/main/MATH20811%20CW3.pdf).

## Needs of this project

- statistical modeling
- writeup

## Author
**Nurfahimah Mohd Ghazali**

- [Profile](https://github.com/fahimahghazali "Fahimah Ghazali")
- [Email](mailto:fahimahghazali@icloud.com?subject=Hi% "Hi!")
