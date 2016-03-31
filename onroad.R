# load in speciate data
speciate <- read.csv("data/speciate-4-4.csv")

# load libraries
library(dplyr)
library(ggplot2)
library(tidyr)

# Names of profiles
names1 <- speciate$NAME

# Function to check names
namefun <- function(type, maxd = 0.1) {
  names1[agrep(type, names1, max.distance = maxd)] %>% unique(.)
}


# Check names of various on-road, vehicle-related sources
# vehicle exhaust, light/heavy duty, diesel, smoker?!
vehicle <- namefun("vehicle")
# all relevant are road dust
roaddust <- namefun("road dust", maxd= 0)
# break wear and pads, dust
brakes <- namefun("brake")
tire <- namefun("Tire", maxd = 0)


# not relevant
#dust <- namefun("dust", maxd = 0)
#fuel <- namefun("fuel")
#comb <- namefun("combustion")
