source("~/StatsBombVizWC2018/SQLFunctions.R")
library(dplyr)




attachPitchValues <- function(eventData){
  result <- left_join(eventData, pitchValuesSQLQuery(), by = c("xlocation" = "xlocation", "ylocation" = "ylocation"))
}

attachPassDestinationPitchValues <- function(passEventData){
  data <- pitchValuesSQLQuery()
  colnames(data)[colnames(data)=="locationxG"] <- "passDestinationxG"
  result <- left_join(passEventData, data, by =  c("pass_end_xlocation" = "xlocation", "pass_end_ylocation" = "ylocation") )
}


getPassValueEvents <- function(){
  result <- attachPitchValues(passSQLQuery()) %>% attachPassDestinationPitchValues()
}

teamPassEvents <- function(teamName){
  result <- filter(getPassValueEvents(), team_name == teamName)
}

playerPassEvents <- function(playerName){
  result <- filter(getPassValueEvents(), player_name == playerName)
}


