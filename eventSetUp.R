library("dplyr")

function(eventsFile, valueFile){

events <- read.csv(file=eventsFile, header=TRUE, sep=",")
valueModel <- read.csv(file=valueFile, header=TRUE, sep=",")
events <- left_join(events, valueModel, by = c("xlocation" = "xlocation_master", "ylocation" = "ylocation_master"))
colnames(events)[colnames(events)=="allAroundAveragexG"] <- "locationxG"
events <- select(events, -X)
events <- left_join(events, valueModel, by = c("pass_end_xlocation" = "xlocation_master", "pass_end_ylocation" = "ylocation_master"))
colnames(events)[colnames(events)=="allAroundAveragexG"] <- "passDestinationxG"
events <- select(events, -X)
events$passxGValue <- events$passDestinationxG - events$locationxG
result <- events
}



