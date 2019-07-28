#Topics Covered in the week 11 Code file are as follows:
#Principal Component Analysis
#Eigen values and Eigen Vectors
#Plotting and Interpreting PCA
#Graphical Representation


#Understanding PCA using a simple and easy to understand dataset
mtcars.pca <- prcomp(mtcars[,c(1:7,10,11)], center = TRUE,scale. = TRUE)
#This dataset is built into R and consists of data on cars
summary(mtcars.pca)
#To see the PCA objects use str()
str(mtcars.pca)
#Pre-requisites to be done before we start plotting PCA
#Step1:
install.packages("devtools")
library(devtools)
#Step2:
install_github("vqv/ggbiplot")
library(ggbiplot)
#As ggbiplot is not working and giivng erros while installing. I'm using the professor provided link
#for code practicing
install.packages("ggfortify")
library(ggfortify)
#Plot the graph with new dataset
df <- iris[c(1, 2, 3, 4)]
autoplot(prcomp(df))
#To colorize by non numeric values, pass original data using data keyword and specify by color to a column
autoplot(prcomp(df), data = iris, colour = 'Species')
# To draw each data label using rownames
autoplot(prcomp(df), data = iris, colour = 'Species', label = TRUE, label.size = 3)
#To make plot without points use shape = False
autoplot(prcomp(df), data = iris, colour = 'Species', shape = FALSE, label.size = 3)
#To draw eigenvectors by adding loadings=TRUE
autoplot(prcomp(df), data = iris, colour = 'Species', loadings = TRUE)
#To attach the eigenvectors labels and change some options follow the below step for the execution
autoplot(prcomp(df), data = iris, colour = 'Species',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)
#To disable the scaling, we can do by specifying scale=0
autoplot(prcomp(df), scale = 0)
#To plot factor analysis use of scores option and factanal
d.factanal <- factanal(state.x77, factors = 3, scores = 'regression')
autoplot(d.factanal, data = state.x77, colour = 'Income')
#Another example would be:
autoplot(d.factanal, label = TRUE, label.size = 3,
         loadings = TRUE, loadings.label = TRUE, loadings.label.size  = 3)
#To plot K-means
set.seed(1)
autoplot(kmeans(USArrests, 3), data = USArrests)
#Understanding the data in the form of unique or same colors stating udner same catgory
autoplot(kmeans(USArrests, 3), data = USArrests, label = TRUE, label.size = 3)
#Intall the package for cluster to plot
library(cluster)
autoplot(clara(iris[-5], 3))
#Below code is to draw convex for each cluster
autoplot(fanny(iris[-5], 3), frame = TRUE)
#To get propbability ellipse in later stage, use the below code
autoplot(pam(iris[-5], 3), frame = TRUE, frame.type = 'norm')
#Use of (lfda} package to plot local fisher discriminant analysis
install.packages("lfda")
library(lfda)
# To Local Fisher Discriminant Analysis (LFDA)
model <- lfda(iris[-5], iris[, 5], r = 3, metric="plain")
autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')
# For Semi-supervised Local Fisher Discriminant Analysis (SELF)
model <- self(iris[-5], iris[, 5], beta = 0.1, r = 3, metric="plain")
autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')
#To plot multidimensional scaling, below are the steps to follow
#Step1:
autoplot(eurodist)
# cmdscale is used to perform classical MDS and returns point coordinates as matrix
autoplot(cmdscale(eurodist, eig = TRUE))
#Need to specify label=true to plot labels
autoplot(cmdscale(eurodist, eig = TRUE), label = TRUE, label.size = 3)
#To plot non-metric multidimensional scaling, follow the below steps:
#Step1:
library(MASS)
#Step2: isoMDS is used to perform non metric MDS
autoplot(isoMDS(eurodist), colour = 'orange', size = 4, shape = 3)
# To make a plot without points, use shape =false in the code
autoplot(sammon(eurodist), shape = FALSE, label.colour = 'blue', label.size = 3)
