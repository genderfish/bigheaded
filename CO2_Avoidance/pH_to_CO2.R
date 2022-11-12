# Set Up
#####
library('ggplot2')
library('ggpubr')
library('dplyr')
library('ggpmisc')
library('sjPlot')

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

curve <- read.csv("allFish_pH_CO2_curve.csv")
Exp1 <- read.csv("Exp1_LargeTank_CO2_Avoidance.csv")
Exp1$X1st_Avoid_Measured_CO2_ppm <- as.numeric(X1st_Avoid_Measured_CO2_ppm)
Exp1$X1st_Avoid_Measured_CO2_ppm <- as.numeric(X1st_Avoid_Measured_CO2_ppm)
Exp1$End_Trial_Measured_CO2_ppm <- as.numeric(End_Trial_Measured_CO2_ppm)
str(Exp1)
#####

### LARGE TANK

# Create pH to CO2 ppm curve
p <- ggplot(curve, aes(x = pH, y = ppm)) +
  geom_point(size = 3) +
  stat_poly_line(formula = y ~ poly(x,2,raw=TRUE),
                 size = 2,se = FALSE,color = 'black') +
  stat_poly_eq(label.x = 5.0, formula = y ~ poly(x, 2, raw = TRUE),
               aes(label = paste(after_stat(eq.label),
                   after_stat(rr.label), sep = "*\", \"*"))) +
  scale_y_continuous(name = expression('pCO'[2]*' (ppm)')) +
  scale_x_continuous(name = "pH", breaks = seq(6,8.5,0.5))
p + theme_classic2()

# Create and save figure
tiff("C:/Users/jacki/OneDrive/Documents (Onedrive)/Thesis/Analysis/R_Statistics/Figures/AllFish_pH_to_CO2_curve.tiff", width = 1500, height = 1500, units = "px", res = 300, compression = c("none"))
p
dev.off()

# Calculate 2nd order equation
fit2 <- lm(ppm~poly(pH,2,raw=TRUE), data = curve)
summary(fit2) # graph rounds coefficients in this equation

# Format table to share values from 2nd order equation
library('stargazer')
stargazer(fit2,
          type = "html",
          out = "C:/Users/jacki/OneDrive/Documents (Onedrive)/Thesis/Analysis/R_Statistics/Figures/pH to CO2 Model Table.doc"
)

# Predict CO2 ppm at last avoidance pH
Exp1$pH <- Exp1$Last_Avoid_pH
Exp1$Last_Avoid_Estimated_CO2_ppm <- predict(fit2,newdata = Exp1)

# Differences between measured and predicted 1st avoidance values
Exp1$pH <- Exp1$X1st_Avoid_pH
Exp1$First_Avoid_Estimated_CO2_ppm <- predict(fit2, newdata = Exp1)
Exp1$Difference <- Exp1$First_Avoid_Estimated_CO2_ppm - Exp1$X1st_Avoid_Measured_CO2_ppm
hist(Exp1$Difference)

# summarize results
attach(Exp1)

Exp1_Results <- Exp1 %>% 
  filter_at(vars(X1st_Avoid_Measured_CO2_ppm, End_Trial_Measured_CO2_ppm), all_vars(!is.na(.))) %>% 
  group_by(Species) %>% 
  summarize(
  # FirstAvoid_Measured_ppm = mean(X1st_Avoid_Measured_CO2_ppm),
  # FirstAvoid_SE = sd(X1st_Avoid_Measured_CO2_ppm)/sqrt(length(X1st_Avoid_Measured_CO2_ppm)),
  Alk = mean(Alkalinity_ppm),
  Alk_SE = sd(Alkalinity_ppm)/sqrt(length(Alkalinity_ppm)),
  Temp = mean(Temp_C),
  Temp_SE = sd(Temp_C)/sqrt(length(Temp_C)),
   LastAvoid_Calculated_ppm = mean(Last_Avoid_Estimated_CO2_ppm, na.rm = TRUE),
   LastAvoid_SE = sd(Last_Avoid_Estimated_CO2_ppm)/sqrt(length(Last_Avoid_Estimated_CO2_ppm)),
   EndTrial_Measured_ppm = mean(End_Trial_Measured_CO2_ppm),
   EndTrial_SE = sd(End_Trial_Measured_CO2_ppm)/sqrt(length(End_Trial_Measured_CO2_ppm))
  )
View(Exp1_Results)

# Calculate average avoidance threshold
(28591.33 + 31272.45)/2 # option 1 by hand

mean(Exp1_Results$LastAvoid_Calculated_ppm) # option 2

# option 3
avoidBighead <- Exp1_Results %>%  filter(Species == 'Bighead') %>%   select(LastAvoid_Calculated_ppm)
avoidSilver <- Exp1_Results %>%  filter(Species == 'Silver') %>%   select(LastAvoid_Calculated_ppm)
avoidAvg <- (avoidBighead + avoidSilver)/2 


# Format table for publication
labels <- c("Species","TA (ppm)", "SE", "Temp (C)", "SE","Last Avoidance (ppm)","SE","Trial End (ppm)","SE")
tab_df(Exp1_Results,
       title = "Dissolved carbon dioxide avoidance in large shuttle tank",
       col.header = labels,
       footnote = "text",
       show.footnote = FALSE,
       encoding = "Windows-1252",
       digits = 1,
       file = "C:/Users/jacki/OneDrive/Documents (Onedrive)/Thesis/Analysis/R_Statistics/Figures/Large Tank CO2 Avoidance Table.doc"
       )


# Report CO2 avoidance in figures
# exploratory
boxplot(Last_Avoid_Estimated_CO2_ppm)
boxplot(Last_Avoid_Estimated_CO2_ppm ~ Species)
boxplot(Last_Avoid_pH ~ Species)

# format figure for publication
p <-  ggplot(Exp1, aes(x = Species, y = Last_Avoid_Estimated_CO2_ppm)) +
  geom_boxplot(position = position_dodge(1)) +
  stat_compare_means(
    aes(group = Species),
    method = "wilcox.test",
    label.x = 1.5,
    label = "p",
    hide.ns = FALSE
  ) +
  geom_dotplot(binaxis = 'y',
               stackdir = 'center',
               position = position_dodge(1)) + # add dots
  labs(x = "Species", 
       y = expression("Last Avoidance pCO"[2]*" (ppm)")) +
  theme_classic2()
p

tiff("C:/Users/jacki/OneDrive/Documents (Onedrive)/Thesis/Analysis/R_Statistics/Figures/LargeTank_Last_Avoidance_Boxplot.tiff", width = 1500, height = 1500, units = "px", res = 300, compression = c("none"))
p
dev.off()

wilcox.test(Last_Avoid_Estimated_CO2_ppm~Species)


# Calculate pH at the avoidance threshold
# reverse equation -- ppm to pH
fit <- lm(pH~poly(ppm,2,raw=TRUE), data = curve)

pH <- as.numeric(c("NA", "NA"))
ppm <- as.numeric(c(avoidBighead, avoidSilver))
threshold <- data.frame(pH, ppm)

threshold$pH <- predict(fit, newdata = threshold)
View(threshold)



### SMALL TANK

# Format table for publication
SmallExp1 <- read.csv("Exp1_SmallTank_CO2_Avoidance.csv")
str(SmallExp1)

detach(Exp1)
attach(SmallExp1)

SmallExp1_Results <- SmallExp1 %>% 
#  group_by(Species) %>% # not a high enough N for each speices
  summarize(
    Alk = mean(Alkalinity_Pre),
    Alk_SE = sd(Alkalinity_Pre)/sqrt(length(Alkalinity_Pre)),
    Temp = mean(Temp),
    Temp_SE = sd(Temp)/sqrt(length(Temp)), # unclear why this returns NA
    LastAvoid_Calculated_uatm = mean(CO2_Output_uAtm),
    LastAvoid_SE = sd(CO2_Output_uAtm)/sqrt(length(CO2_Output_uAtm)),
    Measured_ppm = mean(measured_pCO2_ppm, na.rm = TRUE),
    Measured_SE = sd(measured_pCO2_ppm, na.rm = TRUE)/sqrt(5)
  )
SmallExp1_Results$Temp_SE <- sd(Temp)/sqrt(length(Temp))
SmallExp1_Results$Species <- c("Bigheaded")
View(SmallExp1_Results)

labels <- c("TA (ppm)", "SE", "Temp (C)", "SE","Estimated (uatm)","SE","Measured (ppm)","SE")
tab_df(SmallExp1_Results,
       title = "Dissolved carbon dioxide avoidance in small shuttle tank",
       col.header = labels,
       footnote = "text",
       show.footnote = FALSE,
       encoding = "Windows-1252",
       digits = 1,
       file = "C:/Users/jacki/OneDrive/Documents (Onedrive)/Thesis/Analysis/R_Statistics/Figures/Small Tank CO2 Avoidance Table.doc"
)
