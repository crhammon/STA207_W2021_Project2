#Model code 
data(Fatalities, package = "AER")
beertax_1982 <- Fatalities[Fatalities$year == 1982, c('state', 'beertax')]
colnames(beertax_1982) <- c('state', 'beertax_1982')
Fatalities <- merge(Fatalities, beertax_1982, by = 'state')
Fatalities$beertax_change <- Fatalities$beertax - Fatalities$beertax_1982
fit1 <- lm(I(afatal/pop*100000) ~ + state + year + beertax_change + drinkage + breath + jail 
           + service  - 1, 
           data = Fatalities)
summary(fit1)$coefficients[55:59,]
#                 Estimate Std. Error     t value   Pr(>|t|)
#beertax_change -2.920800242  1.3800789 -2.11640085 0.03520583
#drinkage       -0.006112397  0.1488201 -0.04107239 0.96726788
#breathyes      -0.196712302  0.4029563 -0.48817284 0.62581502
#jailyes         2.050847304  1.0026092  2.04551014 0.04175256
#serviceyes     -1.430809165  1.1492343 -1.24501087 0.21418380

#Checking using ANOVA
anova.fit= aov(fit1, data=Fatalities)
summary(anova.fit)
#                Df Sum Sq Mean Sq F value   Pr(>F)    
#state           48  16306   339.7 201.895  < 2e-16 ***
#year             6     58     9.6   5.714 1.28e-05 ***
#beertax_change   1      7     7.2   4.258   0.0400 *  
#drinkage         1      0     0.0   0.010   0.9221    
#breath           1      0     0.3   0.186   0.6664    
#jail             1      6     6.4   3.779   0.0529 .  
#service          1      3     2.6   1.550   0.2142    
#Residuals      276    464     1.7                     
---
#Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#1 observation deleted due to missingness

par(mfrow=c(2,2))
plot(anova.fit)
print(fit1)
plot(fit1)
stats::qqnorm(Fatalities$beertax_change)
#In the QQ Plot, we can see that points are mostly in a line at the middle of the graph and curves off with extreme points.
#This means that the data set contains more extreme values than expected when compared to a Normal distribution. 
#The Residuals vs Fitted plots visually shows that the residuals are mostly around the 0 line. 
#This suggests that the assumption of using a linear relationship is reasonable even though there are outliers present.
#It is evident that there are outliers in this plot. 

fit2 <- lm(I(fatal/pop*100000) ~ + state + year + beertax_change + drinkage + breath + jail 
           + service - 1, 
           data = Fatalities)
summary(fit2)$coefficients[55:59,]

plot(fit2)
a=(Fatalities$pop*100000)
b= (Fatalities$afatal/a)


plot(lm(I(b) ~ + Fatalities$state + Fatalities$year + Fatalities$beertax_change + Fatalities$drinkage + Fatalities$breath + Fatalities$jail + Fatalities$service - 1, data=Fatalities))
 plot(lm(fit1, data=Fatalities))

cooks.distance(fit1)
plot(cooks.distance(fit1))


qqnorm(rstandard(fit1), pch=23, bg='blue', cex=2)

plot(lm())
plot(fitted(fit1), sqrt(abs(rstandard(fit1))), pch=23, bg='blue', ylim=c(0,1))
plot(cooks.distance(fit1), pch=23, bg='blue', cex=2, ylab="Cook's distance")
plot(fit1, which=5)
#Residuals vs Leverage plot allows us to analyze if there are any influential cases or outliers. 
#We can see in the graph that there are a few influential data points. 
#We can see Cook's distance here and cases that are influential to these regression results. 
