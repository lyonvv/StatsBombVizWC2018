source("~/StatsBombVizWC2018/dataPrepFunctions.R")
library(ggplot2)

pitch_lines <- data.frame("x_coordinate" = c(0,120,0,120,0,0,120,120,60,60,0,18,0,18,18,18,0,6,0,6,6,6,120,102,102,120,102,102,120,114,114,120,114,114), "y_coordinate" = c(0,0,80,80,0,80,0,80,0,80,18,18,62,62,18,62,30,30,50,50,30,50,18,18,62,62,18,62,30,30,50,50,30,50), "pitch_piece" = c("left sideline","left sideline","right sideline","right sideline","defensive endline","defensive endline","offensive endline","offensive endline","half line","half line","d box left side","d box left side","d box right side","d box right side","d box cross","d box cross","d 6 left","d 6 left","d 6 right","d 6 right","d 6 cross","d 6 cross","o box left side","o box left side","o box right side","o box right side","o box cross","o box cross","o 6 left","o 6 left","o 6 right","o 6 right","o 6 cross","o 6 cross"))



pass_destination_heat_map <- function(pass_event_data) {
  ggplot(pass_event_data, aes( x=pass_end_xlocation, y=pass_end_ylocation)) +
    stat_density2d(aes(fill = ..density..), geom = "raster", contour = FALSE)  +
    geom_line(data=pitch_lines, aes(x=y_coordinate, y=x_coordinate, group=pitch_piece), color = "#ffffff") +
    geom_point(colour = "red")
    }
  
