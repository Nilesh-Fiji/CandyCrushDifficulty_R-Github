# CandyCrushDifficulty_R-Github
Assessing CandyCrush Level difficulties in R

Candy Crush Saga</a> is a hit mobile game developed by King (part of Activision|Blizzard) that is played by millions of people all around the world. Candy Crush has more than 3000 levels, and new ones are added every week. And with that many levels, it's important to get level difficulty just right. Too easy and the game gets boring, too hard and players become frustrated and quit playing. In this project, I will see how we can use data collected from players to estimate level difficulty. 

The dataset we will use contains one week of data from a sample of players who played Candy Crush back in 2014. The data is also from a single episode, that is, a set of 15 levels. It has the following columns:

player_id: a unique player id
dt the date
level: the level number within the episode, from 1 to 15.
num_attempts: number of level attempts for the player on that level and date.
num_success: number of level attempts that resulted in a success/win for the player on that level and date.

The granularity of the dataset is player, date, and level. That is, there is a row for every player, day, and level recording the total number of attempts and how many of those resulted in a win.
