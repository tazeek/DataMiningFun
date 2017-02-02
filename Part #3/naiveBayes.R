library(e1071)
library(ggplot2)
library(reshape2)
set.seed(666)

# Read in the csv file
df <- read.csv("shuffled_train.csv")

# Convert the target column to factor
df$target <- as.factor(df$target)

# Split dataset into training(70%) and testing(30%)
split_size <- 0.7
n <- nrow(df)
trainIndex <- sample(1:n, size = round(split_size*n), replace=FALSE)
train <- df[trainIndex ,]
test <- df[-trainIndex ,]

# Remove df for memory allocation
rm(df)

# Train model
classifier <- naiveBayes(target ~ ., train)

# Test model 
test$pred <- predict(classifier,test,type="class")

# Save/Load model
FILE <- 'nb.rda'
save(classifier, file = FILE)
load(FILE)

# Create confusion matrix
cm <- as.matrix(table(Actual = test$target, Predicted = test$pred))

# Evaluation metrics 
n <- sum(cm) 
nc <- nrow(cm) 
diag <- diag(cm) 
rowsums <- apply(cm, 1, sum) 
colsums <- apply(cm, 2, sum) 
p <- rowsums / n 
q <- colsums / n

precision <- diag / colsums 
recall <- diag / rowsums 
f1 <- 2 * precision * recall / (precision + recall) 
results <- data.frame(precision, recall, f1) 

# Plot heatmap
normal_df <- data.frame(test$target,test$pred)
names(normal_df) = c("Actual", "Predicted")

actual <- as.data.frame(table(normal_df$Actual))
names(actual) = c("Actual","ActualFreq")

confusion <- as.data.frame(table(test$target, test$pred))
names(confusion) <- c("Actual","Predicted","Freq")

confusion <- merge(confusion, actual, by="Actual")
confusion$Percent <- confusion$Freq/confusion$ActualFreq*100

confusion$Predicted <- with(confusion,factor(Predicted,levels = rev(levels(Predicted))))

# Render plot
# We use three different layers
# First we draw tiles and fill color based on percentage of test cases
tile <- ggplot() +
	geom_tile(aes(x=Predicted, y=Actual,fill=Percent),data=confusion, color="black",size=0.1) +
	labs(x="Actual",y="Predicted")

tile <- tile + 
	geom_text(aes(x=Predicted,y=Actual, label=sprintf("%.1f", Percent)),data=confusion, size=3, colour="black") +
	scale_fill_gradient(low="white",high="green")
 
tile <- tile + 
	geom_tile(aes(x=Predicted,y=Actual),data=subset(confusion, as.character(Actual)==as.character(Predicted)), 
		color="black",size=0.3, fill="black", alpha=0)

tile

#grouped bar graph
df <- as.data.frame(levels(test$target),col.names= c('Class'))
df$precision <- precision
df$recall <- recall
df$f1 <- f1
colnames(df) <- c('Class','Precision','Recall','F1')
df

library(reshape2)
library(plyr)
melted <- melt(df, id.vars=c("Class"))
means <- ddply(melted, c("Class", "variable"), summarise, mean=mean(value))

bargraph <- ggplot(means,aes(Class,mean,fill=variable)) + geom_bar(stat = 'identity',position = 'dodge',width = 0.8) + 
	scale_fill_manual("legend", values = c("Precision" = "green", "Recall" = "orange", "F1" = "blue")) +
	labs(x="Class", y="Score")

bargraph