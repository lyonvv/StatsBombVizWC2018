source("~/StatsBombVizWC2018/SQLFunctions.R")
library(dplyr)




attach_pitch_values <- function(event_data){
  result <- left_join(event_data, pitch_values_SQL_query(), by = c("xlocation" = "xlocation", "ylocation" = "ylocation"))
}

attach_pass_destination_pitch_values <- function(pass_event_data){
  data <- pitch_values_SQL_query()
  rename(data, pass_destinationxG = locationxG) #colnames(data)[colnames(data)=="locationxG"] <- "passDestinationxG"
  result <- left_join(pass_event_data, data, by =  c("pass_end_xlocation" = "xlocation", "pass_end_ylocation" = "ylocation") )
}


get_pass_value_events <- function(){
  result <- attach_pitch_values(pass_SQL_query()) %>% attach_pass_destination_pitch_values()
}

team_pass_events <- function(team_name_input){
  result <- filter(get_pass_value_events(), team_name == team_name_input)
}

player_pass_events <- function(player_name_input){
  result <- filter(get_pass_value_events(), player_name == player_name_input)
}