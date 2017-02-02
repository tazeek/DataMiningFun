library(nnet)
library(ggplot2)
library(dplyr)
library(reshape2)
library(plyr)

data <- read.csv('shuffled_train.csv')

# Convert the target column to factor
data$target <- as.factor(data$target)

training_index <- sample(nrow(data),floor(nrow(data)*0.7))
training_dataset <- data[training_index,]
testing_dataset <- data[-training_index,]

nom <- multinom(target~.,training_dataset)

nom_pred <- predict(nom,testing_dataset,type = 'class')

# Create confusion matrix
cm <- as.matrix(table(Actual = testing_dataset$target, Predicted = nom_pred))

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
normal_df <- data.frame(testing_dataset$target,nom_pred)
names(normal_df) = c("Actual", "Predicted")

actual <- as.data.frame(table(normal_df$Actual))
names(actual) = c("Actual","ActualFreq")

confusion <- as.data.frame(table(testing_dataset$target, nom_pred))
names(confusion) <- c("Actual","Predicted","Freq")

confusion <- merge(confusion, actual, by="Actual")
confusion$Percent <- confusion$Freq/confusion$ActualFreq*100

confusion$Predicted <- with(confusion,factor(Predicted,levels = rev(levels(Predicted))))

# Render plot
# We use three different layers
# First we draw tiles and fill color based on percentage of test case
tile <- ggplot() +
  geom_tile(aes(x=Actual, y=Predicted,fill=Percent),data=confusion, color="blue",size=0.1) +
  labs(x="Actual",y="Predicted")

tile <- tile + 
  geom_text(aes(x=Actual,y=Predicted, label=sprintf("%.1f", Percent)),data=confusion, size=3, colour="black") +
  scale_fill_gradient(low="white",high="green")

tile <- tile + 
  geom_tile(aes(x=Actual,y=Predicted),data=subset(confusion, as.character(Actual)==as.character(Predicted)), 
            color="black",size=0.3, fill="black", alpha=0)

tile

FILE <- 'nn_model.rda'
save(nom, file = FILE)

# grouped bar
df <- as.data.frame(levels(testing_dataset$target),col.names= c('Class'))
df$precision <- precision
df$recall <- recall
df$f1 <- f1
colnames(df) <- c('Class','Precision','Recall','F1')

melted <- melt(df, id.vars=c("Class"))
means <- ddply(melted, c("Class", "variable"), summarise, mean=mean(value))

bargraph <- ggplot(means,aes(Class,mean,fill=variable)) + geom_bar(stat = 'identity',position = 'dodge',width = 0.8) + 
	scale_fill_manual("legend", values = c("Precision" = "green", "Recall" = "orange", "F1" = "blue")) +
	labs(x="Class", y="Score")

bargraph