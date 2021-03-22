library(modelr)
library(broom)
library(tidyverse)
install.packages("fitdistrplus")
library(fitdistrplus)
library(MASS)
install.packages("skimr")
install.packages("GGally")
library(skimr)
library(GGally)



#### Pre-Assignment Work ####
data("mtcars")
glimpse(mtcars)

mod8a = lm(mpg ~ disp, data = mtcars)
summary(mod8a)

ggplot(mtcars, aes(x=disp,y=mpg)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal()

mod8b = lm(mpg ~ qsec, data = mtcars)
ggplot(mtcars, aes(x=disp,y=qsec)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal()

mean(mod8a$residuals^2)
mean(mod8b$residuals^2)
#we see the first plot was better in telling us the effect on our independent variable

#add pred
df8a <- mtcars %>% 
  add_predictions(mod8a) 
df8a[,c("mpg","pred")] %>% head()

# Make a new dataframe with the predictor values we want to assess
# mod1 only has "disp" as a predictor so that's what we want to add here
newdf = data.frame(disp = c(500,600,700,800,900)) # anything specified in the model needs to be here with exact matching column names

# making predictions
pred = predict(mod8a, newdata = newdf)

# combining hypothetical input data with hypothetical predictions into one new data frame
hyp_preds <- data.frame(disp = newdf$disp,
                        pred = pred)

# Add new column showing whether a data point is real or hypothetical
df8a$PredictionType <- "Real"
hyp_preds$PredictionType <- "Hypothetical"

# joining our real data and hypothetical data (with model predictions)
fullpreds <- full_join(df8a,hyp_preds)

fullpreds

ggplot(fullpreds,aes(x=disp,y=pred,color=PredictionType)) +
  geom_point() +
  geom_point(aes(y=mpg),color="Black") +
  theme_minimal()

#### Assignment 8 work ####
df8b <- read_csv("../../Data/mushroom_growth.csv")
unique(df8b)
names(df8b)
skim(df8b)
ggpairs(df8b)

mod8c <- glm(data=df8b,
             formula=GrowthRate ~ Nitrogen*Light*Temperature)
mod8c

add_predictions(df8b,mod8c) %>% 
  ggplot(aes(x=Nitrogen)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=GrowthRate),color="Green",size=1.5) + geom_point(aes(y=Temperature),color="Blue",size=1) +
  geom_point(aes(y=pred),color="Red",size=2,alpha=.5) +
  facet_wrap(~Light)


#taking a look at different models to answer Q#5
mod8d <- glm(data=df8b,
             formula=GrowthRate ~ Nitrogen*Light+Temperature)
mod8d

mod8e <- glm(data=df8b,
             formula=GrowthRate ~ Nitrogen*Light*Temperature+Humidity)
mod8e

mod8f <- glm(data=df8b,
             formula=GrowthRate ~ Nitrogen*Light*Temperature*Humidity)
mod8f

mod8g <- glm(data=df8b,
             formula=GrowthRate ~ Nitrogen*Light*Temperature*Species)
mod8g

mod8h <- glm(data=df8b,
             formula=GrowthRate ~ Nitrogen*Light*Temperature+Species)
mod8h
#f is our frontrunner in residuals
mod8i <- glm(data=df8b,
             formula=GrowthRate ~ Nitrogen*Temperature*Humidity)
mod8i

mod8j <- glm(data=df8b,
             formula=GrowthRate ~ Light*Temperature*Humidity)
mod8j
#j is next closest  so far, but f still leads

mod8k <- glm(data=df8b,
             formula=GrowthRate ~ Light*Temperature*Humidity+Nitrogen)
mod8l <- glm(data=df8b,
             formula=GrowthRate ~ Temperature*Humidity)
mod8m <- glm(data=df8b,
             formula=GrowthRate ~ Temperature*Nitrogen)
mod8n <- glm(data=df8b,
             formula=GrowthRate ~ Temperature*Nitrogen*Species*Light*Humidity)
modhyp <- glm(data=df8b,
              formula=GrowthRate ~ Humidity*Light*Species)
              
summary(mod8n)
preds <- add_predictions(df8b,mod8n)
preds$pred %>% unique
preds$pred %>% table()

#Defining different models (assignment Q#3)

mod8nn <- lm(data=df8b,
             formula=GrowthRate ~ Temperature*Nitrogen*Species*Light*Humidity)
mod8nnn <- aov(data=df8b,
             formula=GrowthRate ~ Temperature*Nitrogen*Species*Light*Humidity)
#This (mod8nseries) represent the best model so far...using all of the independent variables
#Part of question #5

#plotting some of the mods made. 
add_predictions(df8b,mod8f) %>% 
  ggplot(aes(x=Nitrogen)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=GrowthRate),color="Green",size=1.5) + geom_point(aes(y=Temperature),color="Blue",size=1) +
  geom_point(aes(y=pred),color="Red",size=2,alpha=.5) +
  facet_wrap(~Light)

add_predictions(df8b,mod8n) %>% 
  ggplot(aes(x=Nitrogen)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=GrowthRate),color="Green",size=1.5) + geom_point(aes(y=Temperature),color="Blue",size=1) +
  geom_point(aes(y=pred),color="Red",size=2,alpha=.5) + geom_smooth(aes(y=GrowthRate),method="lm") +
  facet_wrap(~Light)

add_predictions(df8b,mod8n) %>% 
  ggplot(aes(x=Light,color=Species)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=pred),color="Black",size=2,alpha=.25) + 
  geom_smooth(aes(y=GrowthRate),method="lm")

step <- stepAIC(mod8n)
step$call

mod8o <- glm(data=df8b,
             formula = step$call)

#use gather_predictions with 2 or more models 
gather_predictions(df8b,mod8f,mod8n) %>% 
  ggplot(aes(x=Light,color=Species)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=pred),color="Black",size=2,alpha=.25) + 
  geom_smooth(aes(y=GrowthRate),method="lm") +
  facet_wrap(~model)

#crazy plot
gather_predictions(data = df8b,mod8f,mod8n) %>% 
  ggplot(aes(x=Nitrogen)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=GrowthRate),color="Green",size=1.5) + geom_point(aes(y=Temperature),color="Blue",size=1) +
  geom_point(aes(y=pred),color="Red",size=2,alpha=.5) + geom_smooth(aes(y=GrowthRate),method="lm") +
  facet_wrap(~Light)


gather_predictions(df8b,mod8f,mod8n,mod8o) %>% 
  ggplot(aes(x=Light,color=Species)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=pred),color="Black",alpha=.25) + 
  geom_smooth(aes(y=GrowthRate),method="lm") +
  facet_wrap(~model)

summary(mod8o)

#residuals (mean square roots) Question #4 in Assignment
sqrt(mean(residuals(mod8c)^2))
sqrt(mean(residuals(mod8d)^2))
sqrt(mean(residuals(mod8e)^2))
sqrt(mean(residuals(mod8f)^2))
sqrt(mean(residuals(mod8g)^2))
sqrt(mean(residuals(mod8h)^2))
sqrt(mean(residuals(mod8i)^2))
sqrt(mean(residuals(mod8j)^2))
sqrt(mean(residuals(mod8k)^2))
sqrt(mean(residuals(mod8l)^2))
sqrt(mean(residuals(mod8m)^2))
sqrt(mean(residuals(mod8n)^2))
sqrt(mean(residuals(mod8o)^2)) #residual is higher than the full mod, but more significance is found; residual very close, too.
sqrt(mean(residuals(mod8nn)^2))
sqrt(mean(residuals(mod8nnn)^2))
# or abs(residuals(mod8o)) %>% mean()
abs(residuals(mod8nn)) %>% mean()
abs(residuals(mod8nnn)) %>% mean()

ggplot(df8b, aes(x=Nitrogen,y=GrowthRate,color=Species)) +
  geom_point() +
  geom_smooth(formula = y~ poly(x,3))

mod8n$formula

mod8p <- glm(data=df8b,
             formula = GrowthRate ~ Temperature * Nitrogen * Species * Light * Humidity)

df8b %>% 
  mutate(transformed_Nitrogen = sqrt(Nitrogen)) %>% 
  ggplot(aes(x=transformed_Nitrogen,y=GrowthRate,color=Species))+ 
  geom_point() + geom_smooth()

plot(rnorm(1000))

ggplot(df8b,aes(x=sqrt(Nitrogen))) + geom_density

mod8q <- glm(data=df8b,
             formula = GrowthRate ~ Species * Light)

mod8r <- aov(data=df8b,
             formula = GrowthRate ~ Species * Light)

summary(mod8q)
summary(mod8r)
#AOV good for looking at categorical info and determining significance

TukeyHSD(mod8r) %>% plot()

tidy(mod8n)
tidy(mod8o) %>% 
  filter(estimeate < 0)

#Hypothetical Data

df$Temperature
spp <- "P.ostreotus"
hum <- "Low"
temp <- 10
ligh <- 0

hyp_data <- data.frame(Species=spp,
           Humidity=hum,
           Temperature=temp,
           Light=ligh)

df$Nitrogen
spp <- "P.ostreotus"
hum <- "Low"
temp <- 20
ligh <- 0
nit <- 15
  
hyp_data2 <- data.frame(Species=spp,
                        Humidity=hum,
                        Temperature=temp,
                        Light=ligh,
                        Nitrogen=nit)

df$Nitrogen
spp <- "P.cornucopiae"
hum <- "Low"
temp <- 20
ligh <- 0
nit <- 15

hyp_data3 <- data.frame(Species=spp,
                        Humidity=hum,
                        Temperature=temp,
                        Light=ligh,
                        Nitrogen=nit)


add_predictions(hyp_data,mod8n)
add_predictions(hyp_data,modhyp)

gather_predictions(df8b,mod8f,mod8n,mod8o) %>% 
  ggplot(aes(x=Light,color=Species)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=pred),color="Black",alpha=.25) + 
  geom_smooth(aes(y=GrowthRate),method="lm") +
  facet_wrap(~model)

gather_predictions(df8b,mod8f,modhyp,mod8o) %>% 
  ggplot(aes(x=Light,color=Species)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=pred),color="Black",alpha=.25) + 
  geom_smooth(aes(y=GrowthRate),method="lm") +
  facet_wrap(~model)

add_predictions(hyp_data2,mod8n)
add_predictions(hyp_data3,mod8n)
#Assignment Q6
#Assignment Q7
gather_predictions(df8b,mod8o,mod8n) %>% 
  ggplot(aes(x=Nitrogen,color=Species)) + geom_point(aes(y=GrowthRate),alpha=.5) +
  geom_point(aes(y=pred),color="Black",alpha=.25) + 
  geom_smooth(aes(y=GrowthRate),method="lm") +
  facet_wrap(~model)

