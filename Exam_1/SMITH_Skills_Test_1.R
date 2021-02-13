library(tidyverse)
library(patchwork)
library(ggplot2)

read.csv("DNA_Conc_by_Extraction_Date.csv")

df <- read.csv("DNA_Conc_by_Extraction_Date.csv")

?df

#1 Histograms and messing around

plot(x=df$Year_Collected,
     y=df$DNA_Concentration_Ben,
     col=df$Year_Collected,
     main="Ben's DNA Concentration Plot",
     xlab="Collection Year",
     ylab="DNA Concentration")

hist(df$DNA_Concentration_Ben,col="darkmagenta",main="Ben's DNA Concentration Histogram",
     xlab="DNA Concentration",
     ylab="Frequency")

hist(df$DNA_Concentration_Katy,col="red",main="Katy's DNA Concentration Histogram",
     xlab="DNA Concentration",
     ylab="Frequency")

ggplot(df, aes(x=DNA_Concentration_Ben,)) + geom_histogram() +
  theme_minimal() +
  labs(x="DNA Concentration",y="Frequency",title = "Ben's DNA Concentration")

ggplot(df, aes(x=DNA_Concentration_Katy,)) + geom_histogram() +
  theme_minimal() +
  labs(x="DNA Concentration",y="Frequency",title = "Katy's DNA Concentration")

names(df)
class(df$Year_Collected)
class(df$DNA_Concentration_Ben)
as.character(df$Year_Collected)

year_character <- as.character(df$Year_Collected)
class(df$Year_Collected)
class(year_character)



# Part 2: Ben and Katy's Extractions tried with ggplot then normal plot()

ggplot(df, aes(x=year_character,y=DNA_Concentration_Ben)) + geom_boxplot(outlier.shape = 1,
  outlier.size = 2) +
  theme_bw() + theme(panel.grid.major = element_blank()) + theme(panel.grid.minor = element_blank()) +
  labs(x="YEAR",y="DNA Concentration",title = "Ben's Extractions")

ggplot(df, aes(x=year_character,y=DNA_Concentration_Katy)) + geom_boxplot(outlier.shape = 1,
  outlier.size = 2) +
  theme_bw() + theme(panel.grid.major = element_blank()) + theme(panel.grid.minor = element_blank()) +
  labs(x="YEAR",y="DNA Concentration",title = "Katy's Extractions")

#Got them with the regular plot()

boxplot(df$DNA_Concentration_Ben~df$Year_Collected,
        col=FALSE,
        main="Ben's Extractions",
        xlab="Collection Year",
        ylab="DNA Concentration")

boxplot(df$DNA_Concentration_Katy~df$Year_Collected,
        col=FALSE,
        main="Katy's Extractions",
        xlab="Collection Year",
        ylab="DNA Concentration")

# Part 3: Saving the plots as jpeg as instructed

jpeg("./SMITH_Plot1.jpeg")
boxplot(df$DNA_Concentration_Katy~df$Year_Collected,
        col=FALSE,
        main="Katy's Extractions",
        xlab="Collection Year",
        ylab="DNA Concentration")
dev.off()

jpeg("./SMITH_Plot2.jpeg")
boxplot(df$DNA_Concentration_Ben~df$Year_Collected,
        col=FALSE,
        main="Ben's Extractions",
        xlab="Collection Year",
        ylab="DNA Concentration")
dev.off()

#Part 4: Comparing Ben's lowest performance relative to Katy's performance


df[df$DNA_Concentration_Ben & df$Year_Collected==2000,]
Ben2000 <- df[df$DNA_Concentration_Ben & df$Year_Collected==2000,]
df[df$DNA_Concentration_Katy & df$Year_Collected==2000,]
Katy2000 <- df[df$DNA_Concentration_Katy & df$Year_Collected==2000,]
Ben2000 - Katy2000
#couldn't quite get that function the way I wanted

mean(df[c(1:17),c(5)]) - mean(df[c(1:17),c(4)])       #2000 = 0.3386712
mean(df[c(18:39),c(5)]) - mean(df[c(18:39),c(4)])     #2001 = 0.4662879
mean(df[c(40:63),c(5)]) - mean(df[c(40:63),c(4)])     #2002 = 0.4443151
mean(df[c(64:87),c(5)]) - mean(df[c(64:87),c(4)])     #2003 = 0.3568207
mean(df[c(88:104),c(5)]) - mean(df[c(88:104),c(4)])   #2004 = 0.5319041
mean(df[c(105:120),c(5)]) - mean(df[c(105:120),c(4)]) #2005 = 0.7914491
mean(df[c(121:131),c(5)]) - mean(df[c(121:131),c(4)]) #2006 = 0.7745523
mean(df[c(132:140),c(5)]) - mean(df[c(132:140),c(4)]) #2007 = 0.9073861
mean(df[c(141:157),c(5)]) - mean(df[c(141:157),c(4)]) #2008 = 0.7227502
# No 2009 Extraction Data
mean(df[c(158:174),c(5)]) - mean(df[c(158:174),c(4)]) #2010 = 0.7045283
mean(df[c(175:194),c(5)]) - mean(df[c(175:194),c(4)]) #2011 = 0.6718553
mean(df[c(195:200),c(5)]) - mean(df[c(195:200),c(4)]) #2012 = 0.7086559

#It turns out Ben's performance RELATIVE to Katy's was the first year we have data for, year 2000

#And to display them with less fragile code
mean(df$DNA_Concentration_Ben[c(1:17)]) - mean(df$DNA_Concentration_Katy[c(1:17)])
mean(df$DNA_Concentration_Ben[c(18:39)]) - mean(df$DNA_Concentration_Katy[c(18:39)])
mean(df$DNA_Concentration_Ben[c(40:63)]) - mean(df$DNA_Concentration_Katy[c(40:63)])
mean(df$DNA_Concentration_Ben[c(64:87)]) - mean(df$DNA_Concentration_Katy[c(64:87)])
mean(df$DNA_Concentration_Ben[c(88:104)]) - mean(df$DNA_Concentration_Katy[c(88:104)])
mean(df$DNA_Concentration_Ben[c(105:120)]) - mean(df$DNA_Concentration_Katy[c(105:120)])
mean(df$DNA_Concentration_Ben[c(121:131)]) - mean(df$DNA_Concentration_Katy[c(121:131)])
mean(df$DNA_Concentration_Ben[c(132:140)]) - mean(df$DNA_Concentration_Katy[c(132:140)])
mean(df$DNA_Concentration_Ben[c(141:157)]) - mean(df$DNA_Concentration_Katy[c(141:157)])
mean(df$DNA_Concentration_Ben[c(158:174)]) - mean(df$DNA_Concentration_Katy[c(158:174)])
mean(df$DNA_Concentration_Ben[c(175:194)]) - mean(df$DNA_Concentration_Katy[c(175:194)])
mean(df$DNA_Concentration_Ben[c(195:200)]) - mean(df$DNA_Concentration_Katy[c(195:200)])
# Gives the same mean values of Ben's extractions minus Katy's as the previous code, but is the preferred code

# Just extra visuals below

p1 <- ggplot(df, aes(x=Year_Collected,y=DNA_Concentration_Katy)) + geom_point() +
  theme_minimal() + geom_smooth() +
  labs(x="DNA Concentration",y="Frequency",title = "Katy's DNA Concentration")
 
p2 <- ggplot(df, aes(x=Year_Collected,y=DNA_Concentration_Ben)) + geom_point() +
  theme_minimal() + geom_smooth() +
  labs(x="DNA Concentration",y="Frequency",title = "Ben's DNA Concentration")

p1 + p2
      
plot(x=df$Year_Collected,
     y=df$DNA_Concentration_Ben,
     col=df$Year_Collected,
     main="Ben's DNA Concentration Plot",
     xlab="Collection Year",
     ylab="DNA Concentration")

plot(x=df$Year_Collected,
     y=df$DNA_Concentration_Katy,
     col=df$Year_Collected,
     main="Katy's DNA Concentration Plot",
     xlab="Collection Year",
     ylab="DNA Concentration")
# In these plots you can see visually see the relative performances for both and the answer for year 20000 makes sense.


#5 Excluding the 'upstairs' lab data
Downstairs_subset <- df[df$Lab=="Downstairs",]

ggplot(Downstairs_subset, aes(x=Date_Collected,y=DNA_Concentration_Ben)) + geom_point(shape=1,size=2) +
  theme_bw() + theme(panel.grid.major = element_blank()) + theme(panel.grid.minor = element_blank()) +
  theme(strip.text = element_blank())
#Couldn't figure out the x-axis date collected grid

#Instructions say to save as jpg not jpeg
jpeg("./Ben_DNA_over_time.jpg")
ggplot(Downstairs_subset, aes(x=Date_Collected,y=DNA_Concentration_Ben)) + geom_point(shape=1,size=2) +
  theme_bw() + theme(panel.grid.major = element_blank()) + theme(panel.grid.minor = element_blank()) +
  theme(strip.text = element_blank())
dev.off()

#6 
#We can see that 2007 had the highest average concentration for Ben's extractions by observing the graphs made.

df$Year_Collected == c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2010,2011,2012)
myrow <- df$Year_Collected == c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2010,2011,2012)
#hmm nope


df$DNA_Concentration_Ben
Ben_values <- df$DNA_Concentration_Ben
Ben_values

mean(df$DNA_Concentration_Ben[c(1:17)])    #0.4844271  2000
mean(df$DNA_Concentration_Ben[c(18:39)])   #0.5428083  2001
mean(df$DNA_Concentration_Ben[c(40:63)])   #0.5651776  2002
mean(df$DNA_Concentration_Ben[c(64:87)])   #0.4378957  2003
mean(df$DNA_Concentration_Ben[c(88:104)])  #0.7310512  2004
mean(df$DNA_Concentration_Ben[c(105:120)]) #1.283827   2005
mean(df$DNA_Concentration_Ben[c(121:131)]) #1.219825   2006
mean(df$DNA_Concentration_Ben[c(132:140)]) #1.463386   2007
mean(df$DNA_Concentration_Ben[c(141:157)]) #1.184985   2008
mean(df$DNA_Concentration_Ben[c(158:174)]) #1.183822   2010
mean(df$DNA_Concentration_Ben[c(175:194)]) #1.120605   2011
mean(df$DNA_Concentration_Ben[c(195:200)]) #1.092156   2012

#2007 is the correct choice for the year of Ben's highest averages.

ben2000 <- mean(df$DNA_Concentration_Ben[c(1:17)])    
ben2001 <- mean(df$DNA_Concentration_Ben[c(18:39)])   
ben2002 <- mean(df$DNA_Concentration_Ben[c(40:63)])   
ben2003 <- mean(df$DNA_Concentration_Ben[c(64:87)])   
ben2004 <- mean(df$DNA_Concentration_Ben[c(88:104)])  
ben2005 <- mean(df$DNA_Concentration_Ben[c(105:120)]) 
ben2006 <- mean(df$DNA_Concentration_Ben[c(121:131)]) 
ben2007 <- mean(df$DNA_Concentration_Ben[c(132:140)]) 
ben2008 <- mean(df$DNA_Concentration_Ben[c(141:157)]) 
ben2010 <- mean(df$DNA_Concentration_Ben[c(158:174)]) 
ben2011 <- mean(df$DNA_Concentration_Ben[c(175:194)]) 
ben2012 <- mean(df$DNA_Concentration_Ben[c(195:200)]) 

max(ben2000,ben2001,ben2002,ben2003,ben2004,ben2005,ben2006,ben2007,ben2008,ben2010,ben2011,ben2012)
Ben_subset <- df$DNA_Concentration_Ben & df$Year_Collected
df2 <- data.frame(Ben_subset)
df2
#lost...
# The correct code was not obtained for the .csv below
write.csv(Ben_subset,"./Ben_Avg_Conc.csv")
