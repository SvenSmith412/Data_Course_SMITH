library(tidyverse)
library(patchwork)
library(janitor)
library(readxl)
library(tidyr)
library(ggplot2)

#I.      Load the landdata-states.csv file into R ####
#Re-create the graph shown in "fig1.png"
#Export it to your Exam_2 folder as LASTNAME_Fig_1.jpg (note, that's a jpg, not a png)
 #       To change the y-axis values to plain numeric, add options(scipen = 999) to your script

read.csv("landdata-states.csv")

df <- read.csv("landdata-states.csv")

names(df)

class(df$Year)
options(scipen = 999)
year <- as.numeric(df$Year)
class(year)
Region <- (df$region)

jpeg("./SMITH_Fig_1.jpg")
ggplot(df, aes(x=year,y=Land.Value,color=Region)) +
  geom_smooth() + theme_minimal() +
  labs(x="Year", y="Land Value (USD)",legend="Region")
dev.off()

#II.     What is "NA Region???" ####
#Write some code to show which state(s) are found in the "NA" region 

unique(df$region)
unique(df$State)

#wip region_NA <- df[df$region == "",]

#DC, or the Disctrict of Columbia or Washington DC, consists for all of the "NA" regions.

#III.   The rest of the test uses another data set. The unicef-u5mr.csv data. Get it loaded and take a look. ####
#It's not exactly tidy. You had better tidy it!

unicef <- read.csv("unicef-u5mr.csv")

names(unicef) <- names(unicef) %>% make_clean_names()
names(unicef)
unicef_cleaned <- unicef %>%
  pivot_longer(cols = c("u5mr_1950":"u5mr_2015"),
               names_to = "year",
               names_prefix = "u5mr_",
               values_to = "values")
#IV.     Re-create the graph shown in fig2.png ####
#Export it to your Exam_2 folder as LASTNAME_Fig_2.jpg (note, that's a jpg, not a png  

Continent <- unicef_cleaned$continent
class(unicef_cleaned$year)
year_num <- as.numeric(unicef_cleaned$year)

jpeg("./SMITH_Fig_2.jpg")
ggplot(unicef_cleaned, aes(x=year_num, y=values,color=Continent)) +
  geom_point(size=3) + theme_minimal() + theme(axis.text.x=element_text(size=12)) + 
  labs(x="Year",y="Mortality Rate")
dev.off()


#wip  theme(as.POSIXct.numeric(1960,1980,2000))

#IV.     Re-create the graph shown in fig3.png ####
#Note: This is a line graph of average mortality rate over time for each continent 
#(i.e., all countries in each continent, yearly average), this is NOT a geom_smooth() 
#Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg (note, that's a jpg, not a png)

#mean(unicef_cleaned$values)


jpeg("./SMITH_Fig_3.jpg")
ggplot(unicef_cleaned, aes(x=year_num, y=values,color=Continent)) + 
  stat_smooth(size=2, se= FALSE) + theme_minimal() + theme(axis.text.x=element_text(size=12)) + 
  theme(axis.text.y = element_text(size=12)) + lims(y=c(0,300)) +
  labs(x="Year",y="Mean Mortality Rate (deaths per 1000 live births)")
dev.off()

#workinprogress mod_mort <- glm(data=unicef_cleaned,
     #           formula = values ~ year + continent)

#summary(mod_mort)

#residuals(mod_mort)^2 %>% mean() %>% sqrt()

#V.      Re-create the graph shown in fig4.png
#Note: The y-axis shows proportions, not raw numbers
#This is a scatterplot, faceted by region
#Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg (note, that's a jpg, not a png)


class(Values_date)
values_decimal <- unicef_cleaned$values / 1000

jpeg("./SMITH_Fig_4.jpg")
ggplot(unicef_cleaned, aes(x=year_num, y=values_decimal)) +
  geom_point(color="blue",size=1) + theme_minimal() +
  theme(strip.background = element_rect()) +
  facet_wrap(~region) + 
  labs(x="Year",y="Mortality Rate")
dev.off()

#Note to self: Can do 'y = values / 1000' within the ggplot
