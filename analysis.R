# Import libraries
library(ggplot2)
library(scales)
library(dplyr)

# Read in file
df <- read.csv('clean_mushrooms.csv')

# Summary of dataframe
summary(df)

# Check for duplicates
duplicate_rows <- duplicated(df)
num_duplicates <- length(duplicate_rows[duplicate_rows==TRUE])

# Drop veil column since it is dominated 100%
df$veil.type <- NULL

# Visualise for Class label

temp_df <- df %>% 
  group_by(class) %>% 
  summarise(count=n()) %>% 
  mutate(perc=count/sum(count))

ggplot(temp_df, aes(x = factor(class), y = perc*100)) +
	geom_bar(stat='identity', fill="blue") + 
	labs(x = "Class", y = "Percent", title = "Total counts for classes") +
	theme(plot.title = element_text(hjust = 0.5)) 

# Visualise for Odor label 
temp_df <- df %>% 
  group_by(odor,class) %>% 
  summarise(count=n()) %>% 
  mutate(perc=count/sum(count))

ggplot(temp_df, aes(x = factor(odor), y = perc*100)) +
	geom_bar(aes(fill = class), stat='identity', width=.75, position = "dodge") + 
	labs(x = "Odor", y = "Percent", title = "Total counts for odor") +
	theme_minimal(base_size = 14) +
	theme(plot.title = element_text(hjust = 0.5))

# Visualise for Cap Color 
temp_df <- df %>% 
  group_by(cap.color,class) %>% 
  summarise(count=n()) %>% 
  mutate(perc=count/sum(count))

ggplot(temp_df, aes(x = factor(cap.color), y = perc*100)) +
	geom_bar(aes(fill = class), stat='identity', width=.75, position = "dodge") + 
	labs(x = "Cap Color", y = "Percent", title = "Total counts for cap color") +
	theme_minimal(base_size = 14) +
	theme(plot.title = element_text(hjust = 0.5))

# Visualise for habitat 
temp_df <- df %>% 
  group_by(habitat,class) %>% 
  summarise(count=n()) %>% 
  mutate(perc=count/sum(count))

ggplot(temp_df, aes(x = factor(habitat), y = perc*100)) +
	geom_bar(aes(fill = class), stat='identity', width=.75, position = "dodge") + 
	labs(x = "Habitat", y = "Percent", title = "Total counts for habitat") +
	theme_minimal(base_size = 14) +
	theme(plot.title = element_text(hjust = 0.5))