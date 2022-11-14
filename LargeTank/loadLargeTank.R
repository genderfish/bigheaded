setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# Prepare ethovision data file
ethoData <- read.csv("LargeTank_Ethovision.csv")

# prepare response variables that depend on speaker side
ethoData$DistanceToSpeaker_cm <- ifelse(ethoData$Speaker == 'Left', ethoData$LeftDistance_cm, ethoData$RightDistance_cm)
ethoData$InLoud_per <- ifelse(ethoData$Speaker == 'Left', ethoData$InLeft_per, ethoData$InRight_per)

# remove extra vars
ethoData <- ethoData %>% select(-c(LeftDistance_cm,RightDistance_cm,InLeft_per,InRight_per))

# fix variable types
factorColumns <- c("Day", "Fish_ID", "Sound", "Speaker")
ethoData$TrainedWith <- as.factor(gsub("CO2", "Carbon Dioxide", ethoData$TrainedWith))
ethoData <- ethoData %>% 
  mutate_at(factorColumns, factor) %>% 
  mutate_if(is.character, as.numeric)

str(ethoData) # Confirm all variable types are correct


# prepare phonotaxis by hand data
phonoData <- read.csv("LargeTank_Phonotaxis.csv")

factorColumns <- c("Sound", "Fish_ID", "Speaker")
phonoData$TrainedWith <- as.factor(gsub("CO2", "Carbon Dioxide", phonoData$TrainedWith))
phonoData$Day <- factor(phonoData$Days_Since_Train, levels = c("1","3","7"), labels = c("Day 1","Day 3","Day 7"))

phonoData <- phonoData %>% 
  select(-c('Days_Since_Train', 'Date', 'Notes')) %>% 
  mutate_at(factorColumns, factor) %>% 
  mutate_if(is.character, as.numeric)

str(phonoData)

# join ethovision data with by hand data
data <- left_join(ethoData,phonoData)
str(data)
summary(data)

data <- data %>% filter(VID_ID != '44')# removing trial 44 due to error on which side fish was on

# clean up
missingTrial <- anti_join(ethoData,phonoData) # Trial 44 was excluded because sound was played on the incorrect side
rm(factorColumns)
rm(ethoData)
rm(missingTrial)
rm(phonoData)