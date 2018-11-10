source("~/StatsBombVizWC2018/dataPrepFunctions.R")
library(ggplot2)

pitch_lines <- data.frame("x_coordinate" = c(0,120,0,120,0,0,120,120,60,60,0,18,0,18,18,18,0,6,0,6,6,6,120,102,102,120,102,102,120,114,114,120,114,114), "y_coordinate" = c(0,0,80,80,0,80,0,80,0,80,18,18,62,62,18,62,30,30,50,50,30,50,18,18,62,62,18,62,30,30,50,50,30,50), "pitch_piece" = c("left sideline","left sideline","right sideline","right sideline","defensive endline","defensive endline","offensive endline","offensive endline","half line","half line","d box left side","d box left side","d box right side","d box right side","d box cross","d box cross","d 6 left","d 6 left","d 6 right","d 6 right","d 6 cross","d 6 cross","o box left side","o box left side","o box right side","o box right side","o box cross","o box cross","o 6 left","o 6 left","o 6 right","o 6 right","o 6 cross","o 6 cross"))

#http://paletton.com/#uid=6300u0kw0QujHSApLRrOSJ7MFrL

pass_destination_heat_map <- function(pass_event_data) {
  ggplot(pass_event_data, aes( x=pass_end_xlocation, y=pass_end_ylocation)) +
    geom_line(data=pitch_lines, aes(x=y_coordinate, y=x_coordinate, group=pitch_piece), color = "#ffffff", alpha = .4) +
    geom_jitter(colour = "#0481cb", size = 1, alpha = .4)+
    theme(panel.background = element_rect(fill = "#00e673"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())
}
  
pass_destination_heat_map(filter(pass_SQL_query(), player_name == "Paul Labile Pogba", pass_xG_gain > 0.01, pass_outcome == "Complete", !(pass_type %in% c("Corner", "Free Kick", "Goal Kick", "Kick Off", "Throw-In"))))


top_pass_xG_gain_passers <- function(pass_data_input) {
  ggplot(pass_data_input, aes(x=reorder(player_name, total_pass_xG_gain), y=total_pass_xG_gain, fill=team_name)) +
    geom_col() +
    labs(y = "Total Pass xG Gain", x = "", title = "Top Passers by xG Gain - 2018 World Cup",  fill = "Country") +
    coord_flip()
}



top_pass_xG_gain_passers(head(rank_top_xG_gain_passers(filter(pass_SQL_query(), pass_outcome == "Complete", pass_xG_gain > 0, !(pass_type %in% c("Corner", "Free Kick", "Goal Kick", "Kick Off", "Throw-In")))), n=10))

player_both_end_passes <- function(player_name_input){
  filter(pass_with_destination(), player_name == player_name_input, pass_outcome == "Complete", !(pass_type %in% c("Corner", "Free Kick", "Goal Kick", "Kick Off", "Throw-In")))
  }

devtools::install_github('thomasp85/gganimate')

input_data <- filter(player_both_end_passes("Neymar"), pass_xG_gain > 0)

#library(gganimate)
ggplot(input_data, aes(x=xlocation, y=ylocation)) +
  scale_color_gradient(low="#5aeba2", high="#ff8862") +
  stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
  scale_fill_continuous(low="#00e671", high="#ff3d00") +
  geom_line(data=pitch_lines, aes(x=y_coordinate, y=x_coordinate, group=pitch_piece), color = "#ffffff", alpha = .4) +
  geom_line(aes(group=id, colour = pass_xG_gain), size = .3, alpha = 1)+
  geom_point(data=filter(input_data, pass_part == "Origin"), colour = "#5aeba2", size = .6, colour = "#0481cb", alpha = .4)+
  theme(panel.background = element_rect(fill = "#00e671"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  facet_wrap(~result) 

