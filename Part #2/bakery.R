library(stringr)
library(arules)
library(ggplot2)
library(scales)
library(dplyr)
library(arulesViz)

# Read in csv file for items name
food_df <- read.csv('goods.csv', colClasses=c("numeric","character","character","numeric","character"))

# Concatenate the strings and replace ' '
food_df$Item_name <- str_c(food_df$flavor, food_df$food, sep=" ")
food_df$Item_name <- gsub("'","",food_df$Item_name)

# Drop columns in food dataframe
col_drop <- c("flavor","type","price","drink")
food_df <- food_df[ ,!(names(food_df) %in% col_drop)]

# Read in the items csv file
FILE <- "75000_items.csv"
bakery_df <- read.csv(FILE, header=FALSE)

# Give in header names
colnames(bakery_df) <- c("Transaction_ID","Item_count","Item_ID")

# Merge based on Item_ID
bakery_df <- merge(bakery_df, food_df, by="Item_ID")

# Get overall counts and rename column 'x' to 'total_count'
overall_count <- aggregate(bakery_df$Item_count, by=list(Category=bakery_df$Item_name), FUN=sum)
names(overall_count)[names(overall_count) == 'x'] <- 'total_count'

# Reorder variables
overall_count$Category <- as.character(overall_count$Category)
overall_count$Category <- factor(overall_count$Category, levels=unique(overall_count$Category))

# Plot barchart 
#g <- ggplot(overall_count, aes(x = reorder(Category,total_count), y = total_count))
#g + geom_bar(width=.5, stat="identity", fill="green") +  
#	labs(y = "Frequency", x = "Category", title = "Frequency counts for items") +
#	scale_y_continuous(expand = c(0,0)) +
#	theme(plot.title = element_text(hjust = 0.5)) +
#	coord_flip()

# Convert to Transaction Object
trans_bakery <- as(split(bakery_df[, "Item_name"], bakery_df[, "Transaction_ID"]), "transactions")
#inspect(trans_bakery)

# Perform Apriori
rules <- apriori(trans_bakery, parameter=list(support=0.005, confidence=0.65))
#inspect(rules)

# Sort rules
sorted_rules <- sort(rules,by="lift")

# Find redundant rules
subset.matrix <- is.subset(sorted_rules,sorted_rules)
subset.matrix[lower.tri(subset.matrix,diag=T)] <- NA
redundant <- colSums(subset.matrix,na.rm = T) >= 1
#which(redundant)
#sorted_rules[redundant]

# Remove redundant rule
pruned_rules <- sorted_rules[!redundant]
#inspect(pruned_rules)

# Plot graph for sorted rules
plot(sorted_rules)
plot(sorted_rules,method = "grouped")

# Plot graph for pruned rules
plot(pruned_rules)
plot(pruned_rules,method = "graph")
plot(pruned_rules,method = "graph",interactive = TRUE)
plot(pruned_rules,method = "paracoord",control = list(reorder=TRUE))
plot(pruned_rules,method = "grouped",interactive = TRUE)