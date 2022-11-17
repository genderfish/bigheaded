# CO2 trends in large tank
library("reshape")
library("ggplot2")
library("ggpubr")
library("dplyr")

# uncomment to run script outside of CO2_Avoidance.Rmd
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#getwd()

# Prepare large tank pH values
largeCO2 <- read.csv("./Data/CO2_Map_Large.csv") %>% select(-Time) 

stone <- ggplot(largeCO2, aes(x = Seconds, y = CO2_Stone)) +
  geom_point() + theme_classic2() +
  labs(y = "pH at CO2 Stone")
stone

meltCO2_Large <- melt(largeCO2, na.rm = TRUE, id = 'Seconds')
# View(meltCO2)
meltCO2_Large$Tank <- c("Large Tank")


# Prepare small tank pH values
smallCO2 <- read.csv("./Data/CO2_Map_Small.csv") %>% select(-Time) 

meltCO2_Small <- melt(smallCO2, na.rm = TRUE, id = 'Seconds')
meltCO2_Small$Tank <- c("Small Tank")


# join small and large tank datasets
merge <- rbind(meltCO2_Large, meltCO2_Small)

# Scatterplot of pH over time

# Without facet
pH_Trend_Both_Chambers <- ggplot(merge, aes(x = Seconds, y = value, color = variable)) + 
  geom_point() +
 # geom_line() + # connect the dots for each sample location
 # geom_hline(yintercept = 6.44, linetype = "dashed") + # add approximate threshold value
  theme_pubr(legend = "right") +
  scale_color_brewer('Location',
                     palette = 'PuOr', 
                     labels = c(expression('CO'[2]*' Stone'), expression('CO'[2]*' Center'), expression('CO'[2]*' Exit'), 'Air Exit', 'Air Center','Air Stone')
  ) +
  labs(y = "pH", x = "Time (s)") # +

# pH_Trend_Both_Chambers

# With facet
merge$Tank <- factor(merge$Tank, levels = c("Small Tank", "Large Tank"))
 
pH_Trends_Both_Tanks <- ggplot(merge, aes(x = Seconds, y = value, color = variable)) + 
   geom_point(size = 2) +
   xlim(c(0,750)) +
   theme_pubr(legend = "right") +
   scale_color_brewer('Location',
                      palette = 'PuOr', 
                      labels = c(expression('CO'[2]*' Stone'), expression('CO'[2]*' Center'), expression('CO'[2]*' Exit'), 'Air Exit', 'Air Center','Air Stone')
   ) +
   labs(y = "pH", x = "Time (s)") + 
  geom_hline(yintercept = 6.44, linetype = "dashed") + # add approximate threshold value
  facet_grid(Tank ~.)

# pH_Trends_Both_Tanks