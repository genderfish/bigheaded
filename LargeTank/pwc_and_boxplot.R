missing <- data %>% filter(is.na(var) | is.infinite(var))
data2 <- data %>% anti_join(missing)

# remove outliers
outliers <- data2 %>% 
  group_by(Day, TrainedWith, Sound) %>%
  identify_outliers(var)

# extremeOutliers <- outliers %>% 
# filter(is.extreme == "TRUE")
# dataNoExtremeOut <- data2 %>% anti_join(extremeOutliers) # remove only extreme outliers

dataNoOut <- data2 %>% anti_join(outliers) # remove all outliers

# because this is a paired t test, must also remove pairs from outliers & NAs/Inf trials
outlierPairs <- data2 %>% semi_join(outliers, by = c("Fish_ID","TrainedWith","Fish_TrialNum"))
dataNoOut <- dataNoOut %>% anti_join(outlierPairs)

missingPairs <- data %>% semi_join(missing, by = c("Fish_ID","TrainedWith","Fish_TrialNum"))
dataNoOut <- dataNoOut %>% anti_join(missingPairs)

# compute pairwise comparisons
pwc <- dataNoOut %>% 
  group_by(Day,TrainedWith) %>% # alt , TrainedWith
  pairwise_t_test(
    var ~ Sound, # alt ~ TrainedWith
    paired = TRUE, # run as false to see N for each sample
    # conf.level = 0.95, # 95% is the default
    detailed = TRUE, # TRUE gives confidence intervals
    p.adjust.method = "bonferroni"
  )
pwc # %>% select(-df,-statistic,-p)

pwc <- pwc %>% add_xy_position(x = "TrainedWith") # add (x,y) coord on graph for display


# generate boxplot
largeBoxplot <- ggboxplot(dataNoOut, x = "TrainedWith", y = "var",
                                   fill = "Sound",
                                   palette = c("#7570b3", "#d95f02"),
                                   facet.by = "Day",
                                   outlier.shape = NA,
) + 
  # scale_fill_brewer('Sound', palette = "PuOr", na.value = "Pu", labels = c('Before','During')) + 
  theme_classic2() +
  stat_pvalue_manual(pwc, label = "p.adj.signif", y.position = yPosition, tip.length = 0, hide.ns = FALSE) +
  labs(x = "Conditioned With", y = graphLabel, caption = get_pwc_label(pwc))

# largeBoxplot

# keep(data, sure = TRUE)