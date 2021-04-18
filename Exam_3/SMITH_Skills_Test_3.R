#Here we go
library(janitor)
library(patchwork)
library(tidyverse)
library(readxl)
library(tidyr)
library(ggplot2)
library(MASS)
library(skimr)
library(broom)
library(GGally)
library(modelr)
library(fitdistrplus)
library(plotly)
library(dplyr)

#I.      Load and clean FacultySalaries_1995.csv file
#Re-create the graph shown in "fig1.png"
#Export it to your Exam_3 folder as LASTNAME_Fig_1.jpg 

read.csv("FacultySalaries_1995.csv")

df1 <- read.csv("FacultySalaries_1995.csv")

names(df1)

df1b <- df1 %>% 
  select(FedID, UnivName, State, Tier, contains("Salary")) %>% 
  select(-contains("All")) %>% 
  pivot_longer(starts_with("Avg"),names_to = "Rank", values_to = "Salary") %>% 
  mutate(Rank = Rank %>% str_remove_all("Avg")) %>% 
  mutate(Rank = Rank %>% str_remove_all("ProfSalary")) %>% 
  filter(Tier != "VIIB")

jpeg("./SMITH_Fig_1.jpg")
  ggplot(df1b,aes(x=Rank,y=Salary,fill=Rank)) +
  geom_boxplot() +
  facet_wrap(~Tier) +
  theme_minimal() +
  theme(axis.text.x=element_text(angle =60,hjust = 1 ))
dev.off()

plot1 <- ggplot(df1b,aes(x=Rank,y=Salary,fill=Rank)) +
  geom_boxplot() +
  facet_wrap(~Tier) +
  theme_minimal() +
  labs(x="Rank", y="Salary") +
  theme(axis.text.x=element_text(angle =60,hjust = 1 ))

plot1

saveRDS(plot1,"plot1.RDS")



# Export an ANOVA table to a file called "Salary_ANOVA_Summary.txt"
#The ANOVA model should test the influence of "State", "Tier", and 
#"Rank" on "Salary" but should NOT include any interactions between those predictors.

mod1a <- aov(data = df1b,
             formula = Salary ~ State + Tier + Rank)

tidy(mod1a)


write.table(tidy(mod1a), file = "Salary_Anova_Summary.txt", sep = ".\t",
            row.names = TRUE, col.names = NA)


###moving to next csv

read.csv("Juniper_Oils.csv")

df2 <- read.csv("Juniper_Oils.csv")

names(df2) <- names(df2) %>% make_clean_names()


df2 <- df2 %>% 
  pivot_longer(cols=c("alpha_pinene","para_cymene","alpha_terpineol",
                      "cedr_9_ene","alpha_cedrene","beta_cedrene","cis_thujopsene",
                      "alpha_himachalene","beta_chamigrene","cuparene","compound_1",
                      "alpha_chamigrene","widdrol","cedrol","beta_acorenol","alpha_acorenol",
                      "gamma_eudesmol","beta_eudesmol","alpha_eudesmol","cedr_8_en_13_ol",
                      "cedr_8_en_15_ol","compound_2","thujopsenal"),
               names_to="compounds",
               values_to="mass_spec_OD")

# Make me a graph of the following:x = YearsSinceBurn y = Concentration 
# facet = ChemicalID (use free y-axis scales) See Fig2.png for an idea of what I'm looking for

jpeg("./SMITH_Fig_2.jpg")
ggplot(df2,aes(x=years_since_burn, y=mass_spec_OD,color=df$ProfType)) +
  geom_point(alpha=.001) + facet_wrap(~compounds,scales = "free_y") + geom_smooth() + theme_minimal() +
  labs(x="YearsSinceBurn",y="Concentration")
dev.off()

#Use a generalized linear model to find which chemicals show concentrations that are significantly 
#(significant, as in P < 0.05) affected by "Years Since Burn". Use the tidy() function from the 
#broom R package in order to produce a data frame showing JUST the significant chemicals and 
#their model output (coefficient estimates, p-values, etc) 

mod2a <- glm(data = df2,
            formula = mass_spec_OD ~ years_since_burn * compounds)
mod2a

dfsig <- tidy(mod2a)
dfsig

summary(mod2a)

#alpha_cedrine, cedr_8_en_ol, cis_thujopsene, and widdrol show statistical significance

change
