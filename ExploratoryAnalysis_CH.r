library(ggplot2)

data("Fatalities",package = 'AER')
# https://www.rdocumentation.org/packages/AER/versions/1.2-9/topics/Fatalities

ggplot(data = Fatalities) +
  geom_point(mapping = aes(x=state, y = nfatal,size = beertax))