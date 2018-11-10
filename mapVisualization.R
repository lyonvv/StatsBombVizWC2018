library(ggplot2)
library(dplyr)
library(RSQLite)

db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
event_data <- dbGetQuery(conn = db, "select * from event")
dbDisconnect(db)

pitch_lines <- data.frame("x_coordinate" = c(0,120,0,120,0,0,120,120,60,60,0,18,0,18,18,18,0,6,0,6,6,6,120,102,102,120,102,102,120,114,114,120,114,114), "y_coordinate" = c(0,0,80,80,0,80,0,80,0,80,18,18,62,62,18,62,30,30,50,50,30,50,18,18,62,62,18,62,30,30,50,50,30,50), "pitch_piece" = c("left sideline","left sideline","right sideline","right sideline","defensive endline","defensive endline","offensive endline","offensive endline","half line","half line","d box left side","d box left side","d box right side","d box right side","d box cross","d box cross","d 6 left","d 6 left","d 6 right","d 6 right","d 6 cross","d 6 cross","o box left side","o box left side","o box right side","o box right side","o box cross","o box cross","o 6 left","o 6 left","o 6 right","o 6 right","o 6 cross","o 6 cross"))

default_palette <- c("#009C4D", "#FE3025")
reverse_palette <- c("#FE3025", "#009C4D")

indiv_games <- facet_wrap(~result)

map_visualization <- function(team, player, event_type_bucket_input, specific_event_type_input, palette){
  graph_data <- event_data
    
  
  if(missing(team)){
    graph_data <- graph_data
  } else {
   graph_data <- filter(event_data, team_name == team)
    }
  
  if(missing(player)){
    graph_data <- graph_data
  } else {
    graph_data <- filter(event_data, player == player_name)
  }
  
  
  if(missing(event_type_bucket_input)){
    graph_data <- graph_data
  } else if (event_type_bucket_input == 'Offense'){
    graph_data <- filter(graph_data, team == possession_team_name)
  } else if (event_type_bucket_input == 'Defense'){
    graph_data <- filter(graph_data, team != possession_team_name)
  }
  
  
  
  
  if(missing(specific_event_type_input)){
    graph_data <- graph_data
  }
  
  if(missing(palette)){
    palette<-default_palette
  }
  
  
  ggplot(graph_data, aes(xlocation, ylocation)) +
  stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
  scale_fill_continuous(low=palette[1], high=palette[2]) +
  geom_line(data=pitch_lines, aes(x=y_coordinate, y=x_coordinate, group=pitch_piece), color = "#ffffff") +
  geom_jitter(color="#ffffff", alpha = .2, size = .01) +
  theme(panel.background = element_rect(fill = palette[1]),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) #+
    #indiv_games
}

map_visualization(player = "Kieran Trippier")


