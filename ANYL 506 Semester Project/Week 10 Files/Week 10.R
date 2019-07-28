#Topics Covered in the week 10 Code file are as follows:
#K-Means Clustering
#K-MEans ALgorithms
#Clustering Distance Measures
#Building Heatmaps for K-means Solutions
#Hierarchical Cluster Analysis
#Hierarchical Cluster Algorithms
#Types of Hierarchical Clustering
#Determining Optimal Clusters


#To conduct CLuster Analysis we need to have the following requirements ready:
# For data manipulation
library(tidyverse) 
# For clustering algorithms
library(cluster) 
# For clustering algorithms & visualization  
install.packages("factoextra")
library(factoextra) 
#Use new datasets
df <- USArrests
#To remove any missing value that might exists in the data
df <- na.omit(df)
# Use of scaling/standardizing the data using the R function scale:
df <- scale(df)
head(df)
#To find distance matrix between rows of a dat matrix
distance <- get_dist(df)
#To visualize a distance matrix
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
#Computing K-means clustering in R by function kmeans()
k2 <- kmeans(df, centers = 2, nstart = 25)
str(k2)
#To views the results use fviz_cluster()
fviz_cluster(k2, data = df)
#To illustrate the clusters compared to the original variables
df %>%
  as_tibble() %>%
  mutate(cluster = k2$cluster,
         state = row.names(USArrests)) %>%
  ggplot(aes(UrbanPop, Murder, color = factor(cluster), label = state)) +
  geom_text()
#Create multiple values of K to eexamine the differences in the results
k3 <- kmeans(df, centers = 3, nstart = 25)
k4 <- kmeans(df, centers = 4, nstart = 25)
k5 <- kmeans(df, centers = 5, nstart = 25)

# For comparing between the plots
p1 <- fviz_cluster(k2, geom = "point", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = df) + ggtitle("k = 5")

#With the use of grid.arrange() function, 
#we can reproduce the behaviour of the base functions
library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)
#USe of set.seed function is to start arandom sequence that can be reproduced later
set.seed(123)

# Here, we can use function to compute total within-cluster sum of square 
wss <- function(k) {
  kmeans(df, k, nstart = 10 )$tot.withinss}

# TocCompute and plot wss for k = 1 to k = 15
k.values <- 1:15

# To extract wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)
#Now use plot() function to see the graphical form
plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
#To compute the elbow method, it has been wrapped up in a single function
set.seed(123)
fviz_nbclust(df, kmeans, method = "wss")
# This is the function to compute average silhouette for k clusters
avg_sil <- function(k) {
  km.res <- kmeans(df, centers = k, nstart = 25)
  ss <- silhouette(km.res$cluster, dist(df))
  mean(ss[, 3])}

# To compute and plot wss for k = 2 to k = 15
k.values <- 2:15

# To extract avg silhouette for 2-15 clusters
avg_sil_values <- map_dbl(k.values, avg_sil)
#To see the results
plot(k.values, avg_sil_values,
     type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of clusters K",
     ylab = "Average Silhouettes")
#To compute the average silhoutte method which has been wrapped up in a dingle function
fviz_nbclust(df, kmeans, method = "silhouette")
# To compute gap statistics
set.seed(123)
gap_stat <- clusGap(df, FUN = kmeans, nstart = 25,
                    K.max = 10, B = 50)
# To see the results
print(gap_stat, method = "firstmax")
#We can also visulaize the reuslts with fviz_gap_stat
fviz_gap_stat(gap_stat)
#To compute k-means clustering with k = 4
set.seed(123)
final <- kmeans(df, 4, nstart = 25)
#To see the results
print(final)
#Alternative to visulaize the results
fviz_cluster(final, data = df)
#To extract the clusters and add to our initial data with some descriptive information
USArrests %>%
  mutate(Cluster = final$cluster) %>%
  group_by(Cluster) %>%
  summarise_all("mean")

#For to conduct Hierarchical Cluster Analysis, below is another package requirement along with others
## for comparing two dendrograms
library(dendextend) 
#Use new dataset
df <- USArrests
#To remove any missing value that might be present in the data
df <- na.omit(df)
#Scaling and standardizing the data
df <- scale(df)
head(df)
# To understand the Dissimilarity matrix
d <- dist(df, method = "euclidean")
# For Hierarchical clustering using Complete Linkage
hc1 <- hclust(d, method = "complete" )
# To plot the obtained dendrogram
plot(hc1, cex = 0.6, hang = -1)
# To compute with agnes
hc2 <- agnes(df, method = "complete")
# For Agglomerative coefficient
hc2$ac
# These are the methods to assess
m <- c( "average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")
# This function is used to compute coefficient
ac <- function(x) {
  agnes(df, method = x)$ac}
#Returns double vectors
map_dbl(m, ac)
#Other alternative to visualize the dendrogram
hc3 <- agnes(df, method = "ward")
pltree(hc3, cex = 0.6, hang = -1, main = "Dendrogram of diana") 
# To compute divisive hierarchical clustering
hc4 <- diana(df)
# For Divise coefficient; amount of clustering structure found
hc4$dc
# To plot dendrogram
pltree(hc4, cex = 0.6, hang = -1, main = "Dendrogram of diana")
# This is the Ward's method
hc5 <- hclust(d, method = "ward.D2" )
# To cut tree into 4 groups
sub_grp <- cutree(hc5, k = 4)
# To find number of members in each cluster
table(sub_grp)
#Here, we can also use the cutree output to add the the cluster each observation belongs to to our original data.
USArrests %>%
  mutate(cluster = sub_grp) %>%
  head
#Border argument isu sed to specify the border colors for the rectangles
plot(hc5, cex = 0.6)
rect.hclust(hc5, k = 4, border = 2:5)
#To visualize the scatter plot
fviz_cluster(list(data = df, cluster = sub_grp))
# To cut agnes() tree into 4 groups
hc_a <- agnes(df, method = "ward")
cutree(as.hclust(hc_a), k = 4)
# To cut diana() tree into 4 groups
hc_d <- diana(df)
cutree(as.hclust(hc_d), k = 4)
# To compute distance matrix
res.dist <- dist(df, method = "euclidean")
# To compute 2 hierarchical clusterings
hc1 <- hclust(res.dist, method = "complete")
hc2 <- hclust(res.dist, method = "ward.D2")
# Creating two dendrograms
dend1 <- as.dendrogram (hc1)
dend2 <- as.dendrogram (hc2)
#This function plots 2 dendrograms side by side along with the labels conencted by lines
tanglegram(dend1, dend2)
#To create dendlist object from several dendrograms
dend_list <- dendlist(dend1, dend2)
#This can be customized using many other options
tanglegram(dend1, dend2,
           highlight_distinct_edges = FALSE, # Turn-off dashed lines
           common_subtrees_color_lines = FALSE, # Turn-off line colors
           common_subtrees_color_branches = TRUE, # Color common branches 
           main = paste("entanglement =", round(entanglement(dend_list), 2)))
#We need to change the second argument to FUN=hcut to perform the elbow method
fviz_nbclust(df, FUN = hcut, method = "wss")
#To perform the average silhouette method
fviz_nbclust(df, FUN = hcut, method = "silhouette")
#Use of Gap Statistic Method
gap_stat <- clusGap(df, FUN = hcut, nstart = 25, K.max = 10, B = 50)
fviz_gap_stat(gap_stat)

#To illiustrate the K-means algorithm, follow the below steps:
#Step1
set.seed(1234)
#Step2: Sample data
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
#Step3: Plot the dataset where we can see three clusters
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

#Use of k-means function on a dataframe selected using centers 
dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)

#See which cluster each data point got assigned to by looking at the cluster
kmeansObj$cluster

#To build the heatmaps from K-means solutions we need to follow below steps
#Step1: Find the k-means solution
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj <- kmeans(dataMatrix, centers = 3)
#step2:Now make an image plot using the K-means clusters
par(mfrow = c(1, 2))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n", main = "Original Data")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n", main = "Clustered Data")


