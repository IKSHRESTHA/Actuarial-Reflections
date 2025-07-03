#> Initial Information Give about the project 
#> Time_spent_Alone: Hours spent alone daily (0–11).
#> Stage_fear: Presence of stage fright (Yes/No).
#> Social_event_attendance: Frequency of social events (0–10).
#> Going_outside: Frequency of going outside (0–7).
#> Drained_after_socializing: Feeling drained after socializing (Yes/No).
#> Friends_circle_size: Number of close friends (0–15).
#> Post_frequency: Social media post frequency (0–10).
#> Personality: Target variable (Extrovert/Introvert).*
#> 

install.packages("tidyverse")
install.packages("janitor")
library("readr")

personality_dataset <- read_csv("https://raw.githubusercontent.com/IKSHRESTHA/Actuarial-Reflections/refs/heads/main/data/06272925/personality_datasert.csv")

# cleaning the columns name 
df <- personality_dataset |>
  janitor::clean_names()



summary(df)

colSums(is.na(df))

library(dplyr)
stage_fear = df  %>%
  group_by(personality,stage_fear)%>%
  summarise(count = n()) %>%
  ungroup()
stage_fear
library(ggplot2)

# Simple bar plot (dodged bars)
ggplot(stage_fear, aes(x = personality, y = count, fill = stage_fear)) +
  geom_col(position = "dodge") +  # Use "dodge" for side-by-side bars
  geom_text(
    aes(label = count), 
    position = position_dodge(width = 0.9), 
    vjust = -0.5, 
    size = 4
  ) +
  scale_fill_manual(
    values = c("Yes" = "#ff6b6b", "No" = "#74b9ff"),  # Red/Blue colors
    name = "Stage Fear?"
  ) +
  labs(
    title = "Stage Fear by Personality Type",
    x = "Personality",
    y = "Count"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "top"
  )




summary(df)
