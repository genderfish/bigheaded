setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# prepare data directly from ethovision
data <- read.csv("PhonotaxisLargeTank_2022_11_2.csv")
data$X.1 <- data$X.1 %>% str_replace(".* ", "") # remove 'Trial' from string

ethoData <- data %>% 
  select(-X) %>% 
  rename(
    ID = X.1,
    Day = Independent.Variable,
    Editor = Independent.Variable.1,
    FishID = Independent.Variable.2,
    Sound = Independent.Variable.3,
    Speaker = Independent.Variable.4,
    TrainedWith = Independent.Variable.5,
    DistanceMoved_cm = Distance.moved,
    RightDistance_cm = Distance.to.point,
    LeftDistance_cm = Distance.to.point.1, 
    NotMoving_per =  Movement,
    Accel_mean = Acceleration,
    Accel_max = Acceleration.1,
    Accel_sd = Acceleration.2,
    TimeToRight_s = In.zone,
    TimeToLeft_s = In.zone.2,
    InRight_per = In.zone.1,
    InLeft_per = In.zone.3,
    HeadingToLeft_deg = Heading.to.Left,
    HeadingToRight_deg = Heading.to.Right
  )

ethoData <- ethoData[-c(1,2,3),] # remove header rows

# prepare response variables that depend on speaker side
ethoData$DistanceToSpeaker_cm <- ifelse(ethoData$Speaker == 'Left', ethoData$LeftDistance_cm, ethoData$RightDistance_cm)
ethoData$InLoud_per <- ifelse(ethoData$Speaker == 'Left', ethoData$InLeft_per, ethoData$InRight_per)

# remove extra vars
ethoData <- ethoData %>% select(-c(LeftDistance_cm,RightDistance_cm,InLeft_per,InRight_per))

# fix variable types
factorColumns <- c("Day", "Editor", "FishID", "Sound", "Speaker")
ethoData$TrainedWith <- as.factor(gsub("CO2", "Carbon Dioxide", ethoData$TrainedWith))
ethoData <- ethoData %>% 
  mutate_at(factorColumns, factor) %>% 
  mutate_if(is.character, as.numeric)

str(ethoData) # variable types look good?


# prepare phonotaxis by hand data
phonoData <- read.csv("Phonotaxis.csv")

factorColumns <- c("Sound", "FishID", "Speaker")
phonoData$TrainedWith <- as.factor(gsub("CO2", "Carbon Dioxide", phonoData$TrainedWith))
phonoData$Day <- factor(phonoData$Days_Since_Train, levels = c("1","3","7"), labels = c("Day 1","Day 3","Day 7"))

phonoData <- phonoData %>% 
  select(-c('Etho_Delay', 'Days_Since_Train', 'Date', 'Notes')) %>% 
  mutate_at(factorColumns, factor) %>% 
  mutate_if(is.character, as.numeric)
str(phonoData)

# join ethovision data with by hand data
data <- left_join(ethoData,phonoData)
str(data)
summary(data)

data <- data %>% filter(ID != '44')# removing trial 44 due to error on which side fish was on

# clean up
missingTrial <- anti_join(ethoData,phonoData) # Trial 44 was excluded because sound was played on the incorrect side
rm(factorColumns)
rm(ethoData)
rm(missingTrial)
rm(phonoData)