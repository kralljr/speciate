
# File to get SPECIATE in reasonable form

# Load libraries
library(dplyr)
library(tidyr)
library(share)

# Get cons care about
data(consConc)
names <- colnames(consConc[[1]])[-c(1, 2)]
names[names == "OC"] <- "organic carbon"
names[names == "elemental_carbon"] <- "elemental carbon"
names[names == "sodium_ion"] <- "sodium ion"
names[names == "ammonium_ion"] <- "ammonium"

# Read in data
prof <- read.csv("PM_PROFILE-speciate.csv")
prof <- select(prof, P_NUMBER, NAME)
specprop <- read.csv("species-speciate.csv")
specprop <- select(specprop, ID, NAME)
specprop <- rename(specprop, cons = NAME)
spec <- read.csv("PM_SPECIES-speciate.csv")
spec <- select(spec, SPECIES_ID, P_NUMBER, WEIGHT_PER)


# Merge data
# *Note specprop has VOCs, gases, too
spec <- left_join(spec, specprop, by= c("SPECIES_ID" = "ID"))
spec <- full_join(spec, prof, by = "P_NUMBER")
spec <- select(spec, -SPECIES_ID)


# Unique species
spec <- mutate(spec, cons = tolower(cons))
spec <- filter(spec, cons %in% names)


# Reshape
long <- spread(spec, cons, WEIGHT_PER)
write.csv(long, file = "speciate-4-4.csv", row.names = F)
