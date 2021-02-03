
# Packages
library(corrplot)

# Filepaths
fp <- 'C:/Users/noahj/Documents/UCD/2021 Winter Classes/STA 207/Project 2/'
  # Each person can update fp variable for their folder structure
  # Putting the filepath into a variable allows it to be changed easily
  # in case the folder names/structure changes

data("Fatalities", package = "AER")

# Data checks
  table(Fatalities$year)
    # 7 years, 48 observations in each year
  table(Fatalities$state)
    # 48 states, 7 observations in each state

# Correlation Plot
  # Setup data for correlations - omit strings, convert factors to numeric
  Fatalities_num <- Fatalities[,setdiff(colnames(Fatalities),c('state', 'year', 'breath', 'jail', 'service'))]
  Fatalities_num$breath  <- ifelse(Fatalities$breath  == "yes", 1, 0)
  Fatalities_num$jail    <- ifelse(Fatalities$jail    == "yes", 1, 0)
  Fatalities_num$service <- ifelse(Fatalities$service == "yes", 1, 0)
  dim(Fatalities_num)
  Fatalities_num <- na.omit(Fatalities_num)
  dim(Fatalities_num)
    # 1 observation removed
  
  pdf(file = paste0(fp, 'Correlation Plot.pdf'), width = 11, height = 11)
  cor_matrix <- cor(Fatalities_num)
  corrplot.mixed(cor_matrix, upper = 'color', lower = 'number',
                 title = 'Correlation Plot', mar = c(0, 0, 2, 0),
                 lower.col = 'black', number.cex = .7, 
                 tl.pos = 'lt', tl.cex = .7, tl.col = 'black')
  dev.off()



