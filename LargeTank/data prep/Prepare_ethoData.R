# prepare data directly from ethovision
data <- read.csv("LargeTank_Ethovision_raw.csv")
data$X.1 <- data$X.1 %>% str_replace(".* ", "") # remove 'Trial' from string

ethoData <- data %>% 
  select(-c(X, Independent.Variable.1)) %>% 
  rename(
    VID_ID = X.1,
    Day = Independent.Variable,
    #    Editor = Independent.Variable.1,
    Fish_ID = Independent.Variable.2,
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

write.csv(ethoData,"LargeTank_Ethovision.csv", row.names = FALSE)