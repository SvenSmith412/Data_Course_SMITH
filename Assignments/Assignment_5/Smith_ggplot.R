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