##### TASK 1 #####

# This sets the size of plots to a good default.
options(repr.plot.width = 5, repr.plot.height = 4)
install.packages("readr")
library(readr)
install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)


##### TASK 2 : Loading dataset #####

candydf <- read.csv(file.choose(),stringsAsFactors = FALSE)
head(candydf)
# COLUMN DETAILS:
# player_id: a unique player id
# dt: the date
# level: the level number within the episode, from 1 to 15.
# num_attempts: number of level attempts for the player on that level and date.
# num_success: number of level attempts that resulted in a success/win for the player on that level and date

##### TASK 3 : Exploring Dataset #####
str(candydf)
sapply(candydf, class)
candydf$dt <- as.Date(candydf$dt)

# Find number of players
nrow(candydf) #total rows
length(unique(candydf$player_id)) #Distinct player ids
n_distinct(candydf$player_id) #Distinct player ids

#Find period for which we have data
range(candydf$dt)

##### TASK 4: Computing level difficulty #####

level_difficult <- candydf %>%
  group_by(level) %>%
  summarise(attempts = sum(num_attempts), wins = sum(num_success)) %>%
  mutate(probability_of_win = wins/attempts) 

level_difficult

###### TASK 5 : PLOTTING DIFFICULTY PROFILE ######

plot.new() 
ggplot(data=level_difficult, aes(x=level, y=probability_of_win, group=1)) +
  geom_line(color="red")+
  geom_point()+
  scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))+
  scale_y_continuous(labels=scales::percent)+
  labs(x = "Level", y = "Percentage of Wins", caption = "Level Difficulty")

###### TASK 6 : PLOTTING DIFFICULTY PROFILE with SPOTTING HARD LEVEL######

ggplot(data=level_difficult, aes(x=level, y=probability_of_win), group=1) +
  geom_line(color="red")+
  geom_point()+
  geom_hline(yintercept = .10, linetype='dashed')+
  scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))+
  scale_y_continuous(labels=scales::percent)+
  labs(x = "Level", y = "Percentage of Wins", caption = "Level Difficulty")

###### TASK 7 : Compute Std.Error of difficulty for each level######

level_difficult <- level_difficult %>%
  mutate(std_error = sqrt(probability_of_win * (1 - probability_of_win) / attempts))
level_difficult

###### TASK 8 : REPRESENT UNCERTAINTY  ON GRAPH ######

ggplot(data=level_difficult, aes(x=level, y=probability_of_win), group=1) +
  geom_line(color="red")+
  geom_point()+
  geom_hline(yintercept = .10, linetype='dashed')+
  geom_errorbar(aes(ymin = probability_of_win - std_error, ymax = probability_of_win + std_error))+
  scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))+
  scale_y_continuous(labels=scales::percent)+
  labs(x = "Level", y = "Percentage of Wins", caption = "Level Difficulty")

###### TASK 9 : PROBABILITY OF COMPLETING THE EPISODE WITHOUT LOSING A SINGLE TIME ######

p_withoutLosing <- prod(level_difficult$probability_of_win)
p

#####TASK 10 : Should our level designer worry?#####
should_the_designer_worry = FALSE

