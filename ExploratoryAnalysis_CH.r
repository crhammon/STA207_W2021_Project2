library(ggplot2)
library(gplots)
library(plm)
library(clubSandwich)

data("Fatalities",package = 'AER')
# https://www.rdocumentation.org/packages/AER/versions/1.2-9/topics/Fatalities

# ggplot(data = Fatalities) +
  # geom_point(mapping = aes(x=state, y = nfatal,size = beertax))

# pairs(Fatalities[,c('fatal','emppop','youngdrivers','mormon','baptist')])

# plotmeans(afatal/pop~dry, data = Fatalities)
# plotmeans(fatal/pop~drinkage, data = Fatalities)

plotmeans(afatal/pop~breath, data = Fatalities) # bingo

interaction.plot(Fatalities$breath, Fatalities$jail, Fatalities$afatal/Fatalities$pop*100000) # bingo


## initial analysis

Fatalities$afatalper100k = Fatalities$afatal/Fatalities$pop * 1e5

plotmeans(afatalper100k~jail, data = Fatalities) # bingo

# https://www.econometrics-with-r.org/10-3-fixed-effects-regression.html
# from ^^
# estimate the fixed effects regression with plm()

FE_OLS = plm(afatalper100k ~ beertax + year,
                    data = Fatalities,
                    index = c("state"), 
                    model = "within")


coef_test(FE_OLS, vcov = "CR1", cluster = "individual", test = "naive-t")
# coef_test(FE_OLS, vcov = "CR1", cluster = "individual", test = "Satterthwaite")


summary(lm(afatalper100k~beertax + year + state - 1, data = Fatalities))

summary(lm(I(afatalper100k)~beertax + year + state, data = Fatalities))


# plot(FE_OLS, which = 1)


