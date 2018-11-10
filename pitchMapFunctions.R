source("~/StatsBombVizWC2018/dataPrepFunctions.R")
source("~/StatsBombVizWC2018/SQLFunctions.R")


library(ggplot2)
library(dplyr)

pitch_lines <- data.frame("x_coordinate" = c(0,120,0,120,0,0,120,120,60,60,0,18,0,18,18,18,0,6,0,6,6,6,120,102,102,120,102,102,120,114,114,120,114,114), "y_coordinate" = c(0,0,80,80,0,80,0,80,0,80,18,18,62,62,18,62,30,30,50,50,30,50,18,18,62,62,18,62,30,30,50,50,30,50), "pitch_piece" = c("left sideline","left sideline","right sideline","right sideline","defensive endline","defensive endline","offensive endline","offensive endline","half line","half line","d box left side","d box left side","d box right side","d box right side","d box cross","d box cross","d 6 left","d 6 left","d 6 right","d 6 right","d 6 cross","d 6 cross","o box left side","o box left side","o box right side","o box right side","o box cross","o box cross","o 6 left","o 6 left","o 6 right","o 6 right","o 6 cross","o 6 cross"))

offensive_actions <-c("Pass", "Ball Receipt*", "Pressure", "Duel", "Shot", "Ball Recovery", "Dribble", "Foul Won", "Miscontrol", "Dispossessed")
defensive_actions <- c("Pressure", "Duel", "Block", "Clearance", "Foul Committed")

offensive_events <- function(player_name_input){
      data <- all_SQL_query() %>% filter(player_name == player_name_input, event_type %in% offensive_actions)
}

defensive_events <- function(player_name_input){
  data <- all_SQL_query() %>% filter(player_name == player_name_input, event_type %in% defensive_actions)
}

o_input <- offensive_events("Kylian Mbappé")
d_input <- defensive_events("Kylian Mbappé") 


activity_map <- function(event_data_input, event_type_input){
  if(missing(event_type_input)){
    data <- event_data_input
  }else
  {
    data <- filter(event_data_input, event_type == event_type_input)
  }
  
  ggplot(data, aes(x=xlocation, y=ylocation)) +
    stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
    scale_fill_continuous(low="#00e671", high="red") +
    geom_jitter(colour = "#ffffff", size = .1, alpha = .5) +
    geom_line(data=pitch_lines, aes(x=y_coordinate, y=x_coordinate, group=pitch_piece), color = "#ffffff", alpha = .4) +
    theme(panel.background = element_rect(fill = "#00e671"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    facet_wrap(~result)
}


activity_map(d_input)

