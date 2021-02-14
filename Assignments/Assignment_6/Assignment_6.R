library(tidyverse)
library(patchwork)

data("mtcars")
?mtcars

# shows categories. am = automatic
mtcars$am == 0

#display automatics
mtcars[mtcars$am == 0,]
#convert to subset in global environ.
my_subset <- mtcars[mtcars$am == 0,]
#save subset
write.csv(my_subset,"automatic_mtcars.csv")

#effect of hp on mpg
ggplot(my_subset, aes(x=hp,y=mpg)) +
  geom_point() + geom_smooth() + 
  labs(title = "Automatic Car Data: Horsepower vs mpg",x="Horesepower",y="Miles per Gallon")
ggsave("mpg_vs_hp_auto.png")


ggplot(my_subset, aes(x=wt,y=mpg)) +
  geom_point() + geom_smooth() + 
  labs(title = "Automatic Car Data: Weight vs Miles per Gallon",x="Vehicle Weight",y="Miles per Gallon")
ggsave("mpg_vs_wt_auto.tiff")

#less than or equal to 200 cu disp

mtcars[mtcars$disp<=200,]

disp_subset <- mtcars[mtcars$disp<=200,]

write.csv(disp_subset,"mtcars_max200_displ.csv")


mtcars[mtcars$disp<=200 & mtcars$am == 0,]

# under 200 disp OR automatic transmission
mtcars[mtcars$disp<=200 | mtcars$am == 0,]

max(mtcars[mtcars$disp<=200 | mtcars$am == 0,])


max(mtcars$hp) #335
max(disp_subset$hp) #175
max(my_subset$hp) # 245

write.table(max(mtcars$hp),max(disp_subset$hp,max(my_subset$hp)), file = "hp_maximums.txt", sep = ".\t", row.names = FALSE)

write.table(mtcars[mtcars$hp & max(disp_subset$hp) & max(my_subset$hp)]), file = "hp_maximums.txt", sep = ".\t" row.names = FALSE)

#combining the 3 scatterplots from mtcars
p1 <- ggplot(mtcars, aes(x=wt,y=mpg,col=factor(cyl))) +
  geom_point() + geom_smooth(method="lm") + theme_bw() +
  labs(x="Weight",y="Miles per Gallon")

p2 <- ggplot(mtcars, aes(x=cyl,y=mpg,fill=factor(cyl),)) +
  geom_violin(alpha=.5) + theme_bw() +
  labs(x="Cylinders",y="Miles per Gallon")

p3 <- ggplot(mtcars, aes(x=hp,y=mpg,fill=factor(cyl),)) +
  geom_point() + geom_smooth(method="lm") + theme_bw() +
  labs(x="Horsepower",y="Miles per Gallon")

p1 + labs(title="Using Patchwork") + p2 +labs(title = "to combine mtcars") + p3 +labs(title = "Data")
       
p1 + labs(title="Using Patchwork") + p2 +labs(title = "to combine mtcars") + p3 +labs(title = "Data")
ggsave("combined_mtcars_plot.png")
