library(ggplot2)
library(readr)
library(Rtsne)

set.seed(666)

# Subsample items
num_rows_sample <- 20000

# Read in csv file
df <- read.csv("shuffled_train.csv")

# Subsample here
df <- df[sample(1:nrow(df), size = num_rows_sample),]

# Extract features
features <- df[,c(-1,-94)]

# Reduce to two-dimension
tsne <- Rtsne(as.matrix(features), pca = TRUE, perplexity=50, theta=0.5, dims=2)

# Get the features from tsne
embedding <- as.data.frame(tsne$Y)
embedding$Class <- as.factor(df$target)

# Plot in the form of scatter plot
ggplot(embedding, aes(x=V1, y=V2, color=Class)) +
   geom_point(size=1.25) +
   guides(colour = guide_legend(override.aes = list(size=6))) +
   xlab("") + ylab("") +
   theme_light(base_size=20) +
   theme(strip.background = element_blank(),
         strip.text.x     = element_blank(),
         axis.text.x      = element_blank(),
         axis.text.y      = element_blank(),
         axis.ticks       = element_blank(),
         axis.line        = element_blank(),
         panel.border     = element_blank())