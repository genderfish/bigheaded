# CO2 trends in large tank
library("reshape")
library("ggplot2")
library("ggpubr")
library("dplyr")

#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#getwd()

CO2 <- read.csv("./LargeTank_CO2_Trend/CO2_Map.csv")


stone <- ggplot(CO2, aes(x = Seconds, y = CO2_Stone)) +
  geom_point() + theme_classic2() +
  labs(y = "pH at CO2 Stone")
stone


CO2_v2 <- CO2 %>% 
  select(-Time) 

meltCO2 <- melt(CO2_v2, na.rm = TRUE, id = 'Seconds')
# View(meltCO2)

# Scatterplot of pH
pH_Trend_Both_Chambers <- ggplot(meltCO2, aes(x = Seconds, y = value, color = variable)) + 
  geom_point() +
  geom_line() +
  theme_pubr(legend = "right") +
 scale_color_brewer('Location',
                    palette = 'PuOr', 
                    labels = c(expression('CO'[2]*' Stone'), expression('CO'[2]*' Center'), expression('CO'[2]*' Exit'), 'Air Exit', 'Air Center','Air Stone')
                    ) +
  labs(y = "pH", x = "Time (s)") # +
pH_Trend_Both_Chambers
