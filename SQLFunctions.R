library(dplyr)
library(DBI)





db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")


basicFields <-"select id, matchid, [index], period, [timestamp], minute, second, event_type, possession, possession_team_name, play_pattern_name, off_camera, team_name, duration, player_id, player_name, position_name, ylocation, xlocation"
passSource <- " from event where event_type='Pass'"
passFields <- ", pass_recipient_id, pass_recipient_name, pass_length, pass_angle_radians, pass_height, pass_end_xlocation, pass_end_ylocation, pass_type, pass_body_part, pass_outcome, pass_backhe, under_pressure, pass_cross, pass_switch, pass_aerial_won, pass_deflected, pass_miscommunication, pass_assisted_shot_id, pass_goal_assist, pass_shot_assist, pass_through_ball, pass_cut_back"
matchFields <- ", match_date, kick_off, [competition], season_name, home_team, away_team, home_score, away_score, stadium_name, referee_name, matchup, result, is_a_draw, winner, loser, margin_of_victory"

passQuery <- "select id, matchid, [index], period, [timestamp], minute, second, event_type, possession, possession_team_name, play_pattern_name, off_camera, team_name, duration, player_id, player_name, position_name, ylocation, xlocation, pass_recipient_id, pass_recipient_name, pass_length, pass_angle_radians, pass_height, pass_end_xlocation, pass_end_ylocation, pass_type, pass_body_part, pass_outcome, pass_backhe, under_pressure, pass_cross, pass_switch, pass_aerial_won, pass_deflected, pass_miscommunication, pass_assisted_shot_id, pass_goal_assist, pass_shot_assist, pass_through_ball, pass_cut_back, match_date, kick_off, [competition], season_name, home_team, away_team, home_score, away_score, stadium_name, referee_name, matchup, result, is_a_draw, winner, loser, margin_of_victory from event where event_type='Pass'"

eventSQLquery <- function(query){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  result <- dbGetQuery(conn = db, query)
  dbDisconnect(db)
  result
}

passSQLQuery <- function(){
  eventSQLquery(passQuery)
}



teamsSQLQuery <- function(){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  result <- dbGetQuery(db, "select team_name from event group by team_name order by team_name asc")
  dbDisconnect(db)
  result
}

playersSQLQuery <- function(){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  result <- dbGetQuery(db, "select player_name, team_name from event where player_name is not null and player_name != '' group by player_name, team_name order by player_name asc")
  dbDisconnect(db)
  result
}

pitchValuesSQLQuery <- function(){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  result <- dbGetQuery(db, "select xlocation_master as 'xlocation', ylocation_master as 'ylocation', allAroundAveragexG as 'locationxG' from pitchCoordinateValues")
  dbDisconnect(db)
  result
}





