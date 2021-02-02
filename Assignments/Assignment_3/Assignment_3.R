###########################
#                         #
#    Assignment Week 3    #
#                         # 
###########################

# Instructions ####
# Fill in this script with stuff that we do in class.
# It might be a good idea to include comments/notes as well so you remember things we talk about
# At the end of this script are some comments with blank space after them
# They are plain-text instructions for what you need to accomplish.
# Your task is to write the code that accomplished those tasks.

# Then, make sure to upload this to both Canvas and your GitHub repository




# Vector operations! ####

# Vectors are 1-dimensional series of values in some order
1:10 # ':' only works for integers
letters # built-in pre-made vector of a - z



vector1 <- c(1,2,3,4,5,6,7,8,9,10)
vector2 <- c(5,6,7,8,4,3,2,1,3,10)
vector3 <- letters

vector1 + 5
vector2 / 2
vector1*vector2

vector3 + 1 # can't add 1 to "a"



# Data Frames ####
# R has quite a few built-in data sets
data("iris") # load it like this

# For built-in data, there's often a 'help file'
?iris

# "Iris" is a 'data frame.' 
# Data frames are 2-dimensional (think Excel spreadsheet)
# Rows and columns
# Each row or column is a vector


dat <- iris # can rename the object to be easier to type if you want
identical(dat,iris)

# ways to get a peek at our data set
names(dat)
dim(dat)
head(dat)
head(dat,n=4)
?head
tail(dat)

# You can access specific columns of a "data frame" by name using '$'
dat$Species
dat$Sepal.Length
dim(dat$Sepal.Length)
dim(dat)
length(dat$Sepal.Length)
dat$Sepal.Length * dat$Sepal.Width

Sepal.Area <- dat$Sepal.Length * dat$Sepal.Width
dat$Sepal.Area <- Sepal.Area
dat$NEWCOLUMN <- [1:150]

# You can also use square brackets to get specific 1-D or 2-D subsets of a data frame (rows and/or columns)
dat[1,1] # [Rows, Columns]
dat[1:3,5]
dat[1:3,c(1,5)]

# Plotting ####

# Can make a quick plot....just give vectors for x and y axes
?plot
plot(x=dat$Petal.Length, y=dat$Sepal.Length)
plot(x=dat$Species, y=dat$Sepal.Length)
plot(x=dat$Petal.Length[1:50], y=dat$Sepal.Length[1:50])

# Object "Classes" ####

#check the classes of these vectors
class(dat$Petal.Length)
class(dat$Species)

# plot() function behaves differently depending on classes of objects given to it!

# Check all classes (for each column in dat)
str(dat)

# "Classes" of vectors can be changed if needed (you'll need to, for sure, at some point!)

# Let's try
nums <- c(1,1,2,2,2,2,3,3,3,4,4,4,4,4,4,4,5,6,7,8,9)
class(nums) # make sure it's numeric

# convert to a factor
as.factor(nums) # show in console
nums_factor <- as.factor(nums) #assign it to a new object as a factor
class(nums_factor) # check it
as.character(1:10)+1

#check it out
plot(nums) 
plot(nums_factor)
# take note of how numeric vectors and factors behave differently in plot()

# Let's modify and save these plots. Why not!?
?plot()
plot(nums, main = "My Title", xlab = "My axis label", ylab = "My other axis label")


?jpeg()


dev.off()




# Making a data frame ####

# LET'S LEARN HOW TO MAKE A DATA FRAME FROM SCRATCH... WE JUST FEED IT VECTORS WITH NAMES!

# make some vectors *of equal length* (or you can pull these from existing vectors)
col1 <- c("hat", "tie", "shoes", "bandana")
col2 <- c(1,2,3,4)
col3 <- factor(c(1,2,3,4)) # see how we can designate something as a factor             

# here's the data frame command:
data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # colname = vector, colname = vector....
df1 = data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # assign to df1
df1 # look at it...note column names are what we gave it.




# Practice subsetting ####

# Make a data frame from the first 20 rows of iris that has only Species and Sepal.Length columns
# save it into an object called "dat3"
data("iris")
iris[1:20,c("Species","Sepal.Length")]



# WRITING OUT FILES FROM R ####
?write.csv()


# Write your new object "dat3" to a file named "LASTNAME_first_file.csv" in your PERSONAL git repository



### for-loops in R ####

#simplest example:
for(i in 1:10){
  print(i)
}

#another easy one
for(i in levels(dat$Species)){
  print(i)
}

# can calculate something for each value of i ...can use to subset to groups of interest
for(i in levels(dat$Species)){
  print(mean(dat[dat$Species == i,"Sepal.Length"]))
}

getwd()

"A" %in% c("A","B","C")
c("A","D") %in% c("A","B","C")
1:10 > 5
iris$Species == "setosa"
therowsiwant <- iris$Species %in% c("setosa","virginica")

iris[rows,columns]
iris[therowsiwant,] #blank means "ALL" rows or columns
iris[iris$Species %in% c("setosa","virginica"),]


iris[iris$Species == "virginica",]

#sepal length >5
iris[iris$Sepal.Length >5,]
myrows <- iris$Sepal.Length>5
iris[myrows,]
dim(iris[myrows,])

myrows <- iris$Sepal.Length>=6
dim(iris[myrows,])

my_iris <- iris[myrows,]
table(my_iris$Species)
table(iris$Species)

iris[iris$Species,] != "versicolor"

new_iris <- iris[therowsiwant,]
write.csv(new_iris, "./setosa_andvirginica.csv")
write.csv(x=new_iris,file="./setosa_andvirginica.csv")

# YOUR REMAINING HOMEWORK ASSIGNMENT (Fill in with code) ####

# 1.  Make a scatterplot of Sepal.Length vs Sepal.Width. See if you can get the points to be colored by "Species"
plot(x=dat$Sepal.Length, y=dat$Sepal.Width, col=dat$Species)

# 2.  Write the code to save it (with meaningful labels) as a jpeg file
#In-class example:
jpeg("./Sepal_vs_Petal.jpg")
plot(x=dat$Sepal.Length,
     y=dat$Petal.Length,
     col=dat$Species,
     main = "My Title", 
     xlab = "My axis label", 
     ylab = "My other axis label")
dev.off()

# Following the instructions of sepal width vs sepal length and with title and axis labels
jpeg("./Sepal_Length_vs_Width.jpg")
plot(x=dat$Sepal.Length,
     y=dat$Sepal.Width,
     col=dat$Species,
     main = "Sepal Length vs Petal Length", 
     xlab = "Sepal Length", 
     ylab = "Petal Length")
dev.off()

# 3.  Subset the Iris data set to only include rows from the setosa and virginica Species
setosa_and_virginica <- dat[c(1:50,101:150),c(1:5)] #initial attempt "Fragile"

therowsiwant <- iris$Species %in% c("setosa","virginica")

iris[rows,columns]
iris[therowsiwant,] #blank means "ALL" rows or columns



#CTRL-ALT-B runs everycode before
iris$Species == "setosa"

# 4.  Write code to save this new subset as a .csv file called setosa_and_virginica.csv
df <- data.frame(setosa_and_virginica)
write.csv(setosa_and_virginica,"./setosa_and_virginica.csv", row.names = TRUE)

# 5.  Upload this R script (with all answers filled in and tasks completed) to canvas and GitHub
      # I should be able to run your R script and get all the plots created and saved, etc.
