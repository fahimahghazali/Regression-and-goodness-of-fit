rm(list = ls())
swdins=read.table("sweden_ins_data.txt", header = TRUE)


#1
claims = swdins$claims
paym = swdins$payment
plot(claims, paym, xlab = "Claims", ylab = "Payment")

lmswdins = lm(paym~claims)
lmswdins$coefficients
lmswdins$fitted.values
lmswdins$residuals
summary(lmswdins)
names(lmswdins)

#2
slinreg = function(x,y){
  N = length(x)
  par.est = numeric(2)
  y.hat = numeric(N)
  res = numeric(N)
  for (i in 1:N) {
    b.hat = (sum(x*y)-sum(x)*sum(y)/N)/(sum(x^2)-(sum(x)^2/N))
    a.hat = sum(y)/N - b.hat*(sum(x)/N)
    y.hat[i] = a.hat + b.hat*x[i]
    res[i] = y[i] - y.hat[i]
  }
  par.est = c(a.hat, b.hat)
  resdf =N-2
  output = list(par.est, y.hat, res, resdf)
  names(output) = c("parameter.estimates", "fitted.values", "residuals","residual.degrees.of.freedom")
  return(output)
}

slinreg(claims, paym)
names(slinreg(claims, paym))

a.hat = slinreg(claims, paym)$parameter.estimates[1] 
b.hat = slinreg(claims, paym)$parameter.estimates[2] 
fit.val = slinreg(claims, paym)$fitted.values
est.res = slinreg(claims, paym)$residuals


#3i
slinreg(claims, paym)$parameter.estimates
abline(a = a.hat, b = b.hat)
abline(lmswdins)

#3ii
N = length(paym)
sse=sum((paym-fit.val)^2) # residual SS
sse
sigma.hat.sq = sse/(N-2); sigma.hat.sq

#3iii
sst=sum((paym-mean(paym))^2) # total SS
sst
ssr=sum((fit.val-mean(paym))^2) # regression SS
ssr

sse/(N-2)

F=ssr/(sse/(N-2))
F
1-pf(F, df1=1, df2=N-2)

#3iv
surd = (1/N) + ((80 - mean(claims))^2/(sum(claims^2)-(sum(claims)^2/N))) ; surd
t = qt(0.975, N-2); t

ub = a.hat + 80*b.hat + t*sqrt(sigma.hat.sq)*sqrt(surd)
lb = a.hat + 80*b.hat - t*sqrt(sigma.hat.sq)*sqrt(surd)

lb; ub

#4
std.res = rstandard(lmswdins)
plot(fit.val, std.res, xlab = "Fitted values", ylab = "Standardised Residuals")
abline(h = 0)
abline(h = 2, col = "red")
abline(h = -2, col = "blue")

plot(claims, std.res, xlab = "Claims", ylab = "Standardised Residuals")
abline(h = 0)

#5
std.res.ord <- sort(std.res)
n <- length(std.res); n
k = seq(1:n)
pk <- (k - 3/8)/(n + 1/4)
q_th <- qnorm(pk)

plot(q_th, std.res.ord, pch=1, cex=0.5, xlab="Theoretical Quantile Estimate", ylab="Sample Order Statistic")
abline(a=mean(std.res), b=sd(std.res), col="red")

#6
ks.test(std.res.ord, y="pnorm",  alternative = c("two.sided"))
ks.test(std.res, y="pnorm",  alternative = c("two.sided"))

std.res.ecdf<-(1:N)/N
std.res.ecdf

y<-pnorm(std.res.ord)
y


diff1 = std.res.ecdf-y
md1 = max(diff1)
dn.plus = max(md1,0)
dn.plus
std.res.KS1 = std.res.ord[dn.plus==diff1]
std.res.KS1

diff2 = y - std.res.ecdf
md2 = max(diff2)
md2 = md2+(1/N)
dn.minus = max(md2,0)
dn.minus
std.res.KS2 = std.res.ord[dn.minus==diff2+(1/n)]
std.res.KS2

KSstat=max(dn.minus, dn.plus)
KSstat

if(dn.minus < dn.plus) std.res.KS = std.res.KS1
if(dn.minus > dn.plus) std.res.KS = std.res.KS2
std.res.KS

#7
x2 = seq(from=-4, to=4, length.out=600)
px2 = pnorm(x2)

plot(std.res.ord, (1:N)/N, type="s", xlim=c(-4, 4), xlab="x", ylab="")
segments(x0 = std.res.ord[1], y0 = 0, x1 = std.res.ord[1], y1 = 1/N, col = "black")
segments(x0 = std.res.ord[n], y0 = 1, x1 = 4, y1 = 1, col="black")


lines(x2, px2, col="blue")
legend('topleft', c('empirical cumulative distribution function', 'standard normal cdf','KS statistic = 0.1077'), lty=1 ,col=c('black', 'blue', 'green'), bty='n',cex= 0.85)
mtext(text = expression(hat(F)[n](x)), side = 2, line = 2.5)
abline(v = std.res.KS, col = "green")


#8
B = 5000
ysim = numeric(N)
test.sim = 0
for (i in 1:B){
  for (k in 1:N) {
    ysim[k] <- rnorm(1)
  }
  test.sim[i] <- ks.test(ysim, y="pnorm",  alternative = c("two.sided"))$statistic
}

hist(test.sim, freq = FALSE, main = "", xlab = "x")
lines(density(test.sim), col="red")
legend('topright', c('simulated test statistic'), lty=1,col=c('red'), bty='n',cex= 0.85)
quantile(test.sim, probs = 0.95)


