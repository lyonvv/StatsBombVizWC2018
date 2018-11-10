source("~/StatsBombVizWC2018/SQLFunctions.R")
library(dplyr)



team_pass_events <- function(team_name_input){
  result <- filter(pass_SQL_query(), team_name == team_name_input)
}

player_pass_events <- function(player_name_input){
  result <- filter(pass_SQL_query(), player_name == player_name_input)
}

rank_top_xG_gain_passers <- function(pass_data_input){
  result <- pass_data_input %>% group_by(player_name, team_name) %>% 
    summarize(count = n(), total_pass_xG_gain = sum(pass_xG_gain, na.rm = TRUE)) %>%
    arrange(desc(total_pass_xG_gain))
}

pass_with_destination <- function() {
  origin <- pass_SQL_query()
  origin$pass_part <- "Origin"
  origin <- select(origin, -pass_end_xlocation, -pass_end_ylocation)
  destination <- pass_SQL_query()
  destination$pass_part <- "Destination"
  destination <- select(destination, -xlocation, -ylocation)
  destination <- rename(destination, xlocation = pass_end_xlocation, ylocation = pass_end_ylocation)
  result <- rbind(origin, destination)
}




