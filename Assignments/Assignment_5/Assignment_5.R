# ggplot2 intoduction ... Here, we're just looking at what ggplot2 can do and learning about the basic format
# of how to build a plot with this powerful package.

# Load packages we will use
library(tidyverse)
library(carData)
library(RColorBrewer)
library(colorblindr)


# Load the first data set we will work with (built-in to ggplot)
data("midwest", package = "ggplot2")
midwest

# Intro to ggplot syntax

# The syntax for constructing ggplots could be puzzling if you are a beginner or work primarily with base graphics. 
# The main difference is that, unlike base graphics, ggplot works with dataframes and not individual vectors. 
# All the data needed to make the plot is typically be contained within the dataframe supplied to the ggplot() itself 
# or can be supplied to respective geoms. More on that later.
# The second noticeable feature is that you can keep enhancing the plot by adding more layers (and themes) 
# to an existing plot created using the ggplot() function.


# THE BASIC STEPS FOR CREATING A GRAPH:
  # 1. Initialize the plot by giving ggplot a data.frame to work with 
  # 2. Tell ggplot which "aesthetics" to use, and where (x and y axes, colors, sizes, shapes, transparency, etc)
  # 3. Add "geom" layers to display the aesthetics ... geoms tell ggplot how to deal with the aesthetic layers you chose
  # 4. Add labels, make it pretty
  # 5. Bask in your genious

# Let’s initialize a basic ggplot based on the midwest dataset that we loaded.
ggplot(midwest) # what do you see?

# give it some aesthetics to work with...
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'

# A blank ggplot is drawn. Even though the x and y are specified, there are no points or lines in it. 
# This is because, ggplot doesn’t assume that you meant a scatterplot or a line chart to be drawn. 
# I have only told ggplot what dataset to use and what columns should be used for X and Y axis. 
# I haven’t explicitly asked it to draw any points.
# 
# Also note that aes() function is used to specify the X and Y axes. 
# That’s because, any information that is part of the source dataframe has to be specified inside the aes() function.

# Give it a geom to map to your defined aesthetics... Basic Scatterplot, in this case:
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() # The "+" tells ggplot to add another layer to our base plot

# Add another geom ... a trendline:
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method = "lm")
# The line of best fit is in blue. Can you find out what other method options are available for geom_smooth? 

ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method = "lm")
# Another way to build it

# Store your plot as an object to add to...
p <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method = "lm")

p
# can now plot it

# Zoom in
p + lims(x=c(0,0.1),y=c(0,1000000)) # what did this do?
p + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) # how is this different?

p + coord_cartesian(xlim=c(0,0.5), ylim=c(0, 10000))

# Store this new zoomed-in plot
p2 <- p + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))

# Add Title and Labels:
p2 + labs(title="Area Vs Population", 
          subtitle="From midwest dataset", 
          y="Population", 
          x="Area", 
          caption="Midwest Demographics")

# Nifty!  So here's the full function call to make this plot:
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method="lm") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Let's make it pretty ####

# Change color of points and line to static values:
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(color="steelblue",size=3) + 
  geom_smooth(method="lm",color="firebrick") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
# what else did we change, and how?


# Here's where ggplot gets really cool...
# Suppose if we want the color to change based on another column in the source dataset, 
# we can specify "color" inside the "aesthetic" aes() function.
p3 <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(color=state),size=3) + 
  geom_smooth(method="lm",color="firebrick") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
p3

# Don't like those colors?
p3 + scale_color_brewer(palette = "Set1")

p3 + scale_colour_viridis_d()
# Want more color choices? You can check them out in the RColorBrewer package, or even make your own
brewer.pal.info

# Make your own and take a peek at it:
pal <- c("#c4a113","#c1593c","#643d91","#820616","#477887","#688e52",
        "#12aa91","#705f36","#8997b2","#753c2b","#3c3e44","#b3bf2d",
        "#82b2a4","#894e7d","#a17fc1","#262a8e","#abb5b5","#000000")
palette_plot(pal)
# You can even check to see if your color choices would work for someone who has colorblindness...
cvd_grid(palette_plot(pal))

# Our plot with my custom color palette
p3 + scale_color_manual(values=pal)

# Other neat tricks:
p3 + scale_x_reverse()
p3 + theme_minimal()
p3 + theme_dark()

p3 + theme_void()
p3 + theme_light()

# You can also transform your data right in ggplot:
p4 = ggplot(midwest, aes(x=area/max(midwest$area), y=log10(poptotal))) + 
  geom_point(aes(color=state),size=3) + 
  geom_smooth(method="lm",color="firebrick") + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", color = "State",
       y="log10 Population", x="Area (proportion of max)", caption="Midwest Demographics") +
  theme_minimal() +
  scale_color_manual(values=pal)

p4


# Want to divide up your plot into multiple ones based on a categorical variable?
p4 + facet_wrap(~ state)
p4 + facet_wrap(~ state, scales = "free") + theme(legend.position = "none")
p4 + facet_wrap(~ state) + theme(legend.position = "none", strip.text.x = element_text(size = 12, face="bold"))
p4 + facet_wrap(~ state) + theme(legend.position = "none", 
            strip.text.x = element_text(size = 12, face="bold"),
            strip.background = element_rect(fill = "lightblue"))
theme()
#theme('then hit tab to view them')
p4 + theme(axis.title.y = element_text(size = 50, angle=10,vjust=0 ))

# Some other "geom" types ... for categorical x axis
p5 = ggplot(midwest, aes(x=state,y=percollege, fill=state)) + labs(x="State",y="Percent with college degree")
p5

p5 + geom_boxplot()
p5 + geom_violin()
p5 + geom_bar(stat="identity") # something wrong with this picture!

p5 + geom_bar(stat="identity") +
  geom_errorbar()
geom_

# Geoms for looking at a single variable's distribution:
data("MplsStops")

ggplot(MplsStops, aes(x=lat)) + geom_histogram() + labs(title = "Latitude of police stops in Minneapolis - 2017")
ggplot(MplsStops, aes(x=lat, fill = race)) + geom_density(alpha = .5) + labs(title = "Latitude of police stops in Minneapolis - 2017")


ggplot(MplsStops, aes(x=lat, fill = race)) + geom_histogram() + labs(title = "Latitude of police stops in Minneapolis - 2017") +
  facet_wrap(~race)



# Look at lat AND lon
ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_point() + theme_minimal()

ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_point() + theme_minimal() + facet_wrap(~race) # "overplotting!?"
ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_point(alpha=.05) + theme_minimal() + facet_wrap(~race)

ggplot(MplsStops, aes(x=lat,y=long,color=race)) + geom_density_2d() + theme_minimal() + facet_wrap(~race)

ggplot(MplsStops, aes(x=lat,y=long)) + geom_bin2d()

ggplot(MplsStops, aes(x=lat,y=long)) + geom_bin2d() + facet_wrap(~race)




# More advanced understanding of R functions will be required to replicate the following section, but it
# is included as an example follow-up analysis

# Plot using two related data sets
data("MplsDemo") # demographic info by neighborhood can be joined to our police stop dataset

# don't worry about this yet...you'll learn how to do this soon, but I'm just adding mean neighborhood income
# to each row of the police stop data set
income = as.numeric(as.character(plyr::mapvalues(MplsStops$neighborhood, from=MplsDemo$neighborhood, to = MplsDemo$hhIncome)))
MplsStops$income <- income


ggplot(MplsStops, aes(x=lat,y=long,color=income)) + geom_point(alpha=.2)
  
ggplot(MplsStops, aes(x=income)) + geom_histogram(bins = 30)


counts = as.data.frame(table(MplsStops$income))
counts$Var1 <- as.numeric(as.character(counts$Var1))
mod1 = lm(Freq ~ Var1, data = counts)

ggplot(counts, aes(x=Var1,y=Freq)) + geom_point() + geom_smooth(method="lm") +
  labs(x="Mean neighborhood income",y="Numer of police stops",title = "Police stop counts in each neighborhood",
       subtitle = paste0("Adjusted R-sq. value = ",signif(summary(mod1)$adj.r.squared),3)) + 
  theme_minimal()


random_data = data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 11, 4.5) )


# quick look at data
plot(random_data$x)


# Basic scatterplot
ggplot(random_data, aes(x=x, y=y) ) +
  geom_point()

# 2D Density plot, instead
ggplot(random_data, aes(x=x, y=y) ) +
  geom_bin2d() +
  theme_bw()

data("iris")
df1 <- iris

ggplot(iris)

ggplot(iris, aes(x=iris$Sepal.Length - mean(iris$Sepal.Length), color=iris$Species))

ggplot(iris, aes(x=Sepal.Length - mean(Sepal.Length),color=Species))
mean(iris$Sepal.Length)
iris$Sepal.Length - mean(iris$Sepal.Length)

?read.csv()
read.csv2()

iris

install.packages("ggthemes")
library(ggthemes)

iris
library(tidyverse)

#Graph 1
ggplot(iris, aes(x=Sepal.Length,y=Petal.Length,col=Species)) +  geom_point() +
  geom_smooth(method="lm") + theme_minimal() +
  labs(x="Sepal.Length",y="Petal.Length",title = "Sepal length vs petal length",subtitle = "for three iris species")

png(filename = "./Sepal_Length_vs_Petal_Length.png")
ggplot(iris, aes(x=Sepal.Length,y=Petal.Length,col=Species)) +  geom_point() +
  geom_smooth(method="lm") + theme_minimal() +
  labs(x="Sepal.Length",y="Petal.Length",title = "Sepal length vs petal length",subtitle = "for three iris species")
dev.off()

d2 <- density(iris[c(1:150),c(4)])

#Graph 2
ggplot(iris, aes(x=Petal.Width,fill=Species)) +  geom_density(alpha=.5) +
  theme_minimal() + 
  labs(x="Petal Width",y="density",title = "Distribution of Petal Width",subtitle = "for three iris species")

png(filename = "./Distribution_of_Petal_Widths.png")
ggplot(iris, aes(x=Petal.Width,fill=Species)) +  geom_density(alpha=.5) +
  theme_minimal() + 
  labs(x="Petal Width",y="density",title = "Distribution of Petal Width",subtitle = "for three iris species")
dev.off()


pw <- iris[c(1:150),c(4)]
iris$Sepal.Width/iris$Petal.Width
sw_pw <- iris$Sepal.Width/iris$Petal.Width
pw_sw <- iris$Petal.Width/iris$Sepal.Width #used this subset for graph 3

#Graph 3
ggplot(iris, aes(x=Species,y=pw_sw,fill=Species)) +  geom_boxplot() +
  theme_minimal() + scale_color_brewer() +
    labs(x="Species",y="Ratio of Sepal Width to Petal Width",title = "Sepal- to Petal-Width Ratio",subtitle = "for three iris species")

# A way to keep it within the graph (not using a subset)
png(filename = "./Sepal-to_Petal-Width_Ratio.png")
ggplot(iris, aes(x=Species,y=Petal.Width/Sepal.Width,fill=Species)) +  geom_boxplot() +
  theme_minimal() +
  labs(x="Species",y="Ratio of Sepal Width to Petal Width",title = "Sepal- to Petal-Width Ratio",subtitle = "for three iris species")
dev.off()



#Graph #4

iris$Deviance <- iris$Sepal.Length  -mean(iris$Sepal.Length)
iris[sort(iris$Deviance),]
sort(iris$Deviance)
order(iris$Deviance)
iris[order(iris$Deviance),]

iris2 <- iris[order(iris$Deviance),]

ggplot(iris2, aes(x=1:150,y=Sepal.Length -mean(iris$Sepal.Length),fill=Species, width=0.9)) +
         geom_bar(stat="identity") + coord_flip() + theme_minimal()
  labs(x="",y="Deviance from the mean",title = "Sepal length deviance from the mean of all observations",
       caption="Note: Deviance = Sepal.Length -mean(Seapl.Length)") +
    theme(axis.text.y=element_blank())

png(filename = "./Sepal_length_deviance_from_the_mean_of_all_observations.png")    
ggplot(iris2, aes(x=1:150,y=Sepal.Length -mean(iris$Sepal.Length),fill=Species, width=0.9)) +
  geom_bar(stat="identity") + coord_flip() + theme_minimal()
labs(x="",y="Deviance from the mean",title = "Sepal length deviance from the mean of all observations",
     caption="Note: Deviance = Sepal.Length -mean(Seapl.Length)") +
  theme(axis.text.y=element_blank())
dev.off()