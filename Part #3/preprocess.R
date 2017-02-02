library(ggplot2)
library(scales)
library(dplyr)

set.seed(7)

# Read in file 
df <- read.csv('train.csv')

# Drop ID column
df$id <- NULL

# Shuffle Dataframe
df <- df[sample(nrow(df)),]

# Check for duplicated rows
duplicate_rows <- duplicated(df)
num_duplicates <- length(duplicate_rows[duplicate_rows==TRUE])

# Rename labels
df$target <- as.character(df$target)
df$target <- as.integer(gsub("Class_","",df$target))

# Visualise target labels
vis_df <- df %>% 
  group_by(target) %>% 
  summarise(count=n()) %>% 
  mutate(perc=count/sum(count))

# Visualise using ggplot2
ggplot(vis_df, aes(x = factor(target), y = perc*100)) +
	geom_bar(stat='identity', fill="#8b0000") + 
	labs(x = "Class", y = "Distribution", title = "Total counts for classes") +
	theme(plot.title = element_text(hjust = 0.5))

# Write to CSV File 
write.csv(file='shuffled_train.csv', x=df, row.names=FALSE)

# Show distribution
temp_df <- df %>% 
  group_by(target) %>% 
  summarise(count=n()) %>% 
  mutate(perc=count/sum(count))

ggplot(temp_df, aes(x = factor(target), y = perc*100)) +
	geom_bar(stat='identity', fill="blue") + 
	labs(x = "Class", y = "Distribution (%)", title = "Total counts for classes") +
	theme(plot.title = element_text(hjust = 0.5))