#Topics Covered in the week 7 Code file are as follows:
#Data Visualizations
#Graphhing
#AEsthetic Mappings
#Facets
#Geometric Objects
#Statistical Transformations
#Postion Adjustments
#Coordinate Systems


#Pre-requisites to be done to use the datasets
install.packages("tidyverse")
library(tidyverse)
#Load Dataset required from ggplot2
mpg
#This code is to explain how we can create a ggplot having x and y axes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
#To represent data in graphical form. We can map the colors of the points to a variable
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
#Becasue of the mapping on unordered variable to an ordered aesthetic, 
#we get a warning message here
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
#Left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
# Right
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#To make all of the points blue in plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#Careful in placing the '+' in a rite place. Not at the below line
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy))
#Use facet_grid() to facet the plot on combination of 2 variables which is separated by ~
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#Another example for the above function
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
##geom_smooth() is a method to draw a different line with a different linetype for each unique value
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
# Right
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
#Another example for geom_smooth()
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
#Using single geom_smooth and grouping them together
#STep1
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#step2
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
#step3
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE)
#To display multiple goems in the same plot by using ggplot()
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#To avoid duplication for the above code
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
#To display different aesthetics in different layers
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
#Here, the local data argument in geom_smooth() 
#overrides the global data arguemnt in ggplot() for that layer only
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
#Tranforming the graph to different style like bar graph
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
#We can plot the above graph by using the stat_count()
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
#The below code let maps the height of the bars to the raw values of a 'y' variable
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

#Instead of count, we can display a bar chart of proportion
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
#Use of stat_summary() helps in summarizing the y values for each unique x value
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median)
#To color a bar chart, we can use either the colour aesthetic or fill
#step1: For color
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
#step2: To fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
#Another example to fill for a different variable
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
#Adjusting the postions
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
#The below position code will place each object exactly where it falls in the context of graph
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
#The below code works like stacking by making each set of hacked bars the same height
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
#Below code for Postion = "Dodge" places overlapping objects directly beside one another
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
#To avoid gridding, use position adjustment to jitter
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
#To switch the x and y axes, use coord_flip(). Also useful for long labels
#Step1:
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
#Step2:
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
#This code using coord_quickmap() is to set the aspect ratio correctly for maps
#for this we needs to install maps
install.packages("maps")
library(maps)
#Step1:
nz <- map_data("nz")
#Step2:
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
#STep3:
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
#coord_polar() uses polar corodinates. To udnerstand this follow below steps
#Step1:
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
#Step2:
bar + coord_flip()
bar + coord_polar()

  



