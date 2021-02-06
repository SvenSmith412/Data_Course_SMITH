?read.table()
df <- read.csv("../../Data/landdata-states.csv")
read.csv2
# Just got an error
class(df)
head(df)
class(df$State)
class(df$Date)
dim(df)
str(df)
summary(df)
hist(df$Land.Value)
plot(x=df$region,y=df$Land.Value)
# df$region won't plot
class(df$region)
plot(x=df$Year,y=df$Land.Value)
summary(df$Home.Value)
names(df)[4]
plot(x=df$Year,y=df$Land.Value,col=df$region)
# df$region breaks code

df2 <- read.csv2("../../Data/ITS_mapping.csv")
summary(df2)
str(df2)
boxplot(x=df2$Ecosystem,y=df2$Lat)
#doesn't recognize the columns...there is only 1 column...(1 variable)
png(filename = "./silly_boxplot.png")
#whatevercodeyoucameupwithforyourplot
dev.off()

#again, won't create a working boxplot