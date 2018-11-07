source("~/StatsBombVizWC2018/dataPrepFunctions.R")
library(ggplot2)


  
passDesinationHeatMap <- function(passEventData){
  ggplot(passEventData, aes( x=pass_end_xlocation, y=pass_end_ylocation)) +
    stat_density2d(aes(fill = ..density..), geom = "raster", contour = FALSE)  +
    geom_point(colour = "red") +
    coord_flip() +
    scale_x_reverse()
}
  
passDesinationHeatMap(playerPassEvents("Paul Labile Pogba"))
