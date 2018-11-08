library(dplyr)
library(RSQLite)



basic_fields <-"select id, matchid, [index], period, [timestamp], minute, second, event_type, possession, possession_team_name, play_pattern_name, off_camera, team_name, duration, player_id, player_name, position_name, ylocation, xlocation"
pass_source <- " from event where event_type='Pass'"
pass_fields <- ", pass_recipient_id, pass_recipient_name, pass_length, pass_angle_radians, pass_height, pass_end_xlocation, pass_end_ylocation, pass_type, pass_body_part, pass_outcome, pass_backhe, under_pressure, pass_cross, pass_switch, pass_aerial_won, pass_deflected, pass_miscommunication, pass_assisted_shot_id, pass_goal_assist, pass_shot_assist, pass_through_ball, pass_cut_back"
match_fields <- ", match_date, kick_off, [competition], season_name, home_team, away_team, home_score, away_score, stadium_name, referee_name, matchup, result, is_a_draw, winner, loser, margin_of_victory"

pass_query <- "select id, matchid, [index], period, [timestamp], minute, second, event_type, possession, possession_team_name, play_pattern_name, off_camera, team_name, duration, player_id, player_name, position_name, e.ylocation, e.xlocation, x.allAroundAveragexG as 'location_xG', pass_recipient_id, pass_recipient_name, pass_length, pass_angle_radians, pass_height, pass_end_xlocation, pass_end_ylocation, y.allAroundAveragexG as 'pass_end_location_xG', y.allAroundAveragexG - x.allAroundAveragexG as 'pass_xG_gain', pass_type, pass_body_part, pass_outcome, pass_backhe, under_pressure, pass_cross, pass_switch, pass_aerial_won, pass_deflected, pass_miscommunication, pass_assisted_shot_id, pass_goal_assist, pass_shot_assist, pass_through_ball, pass_cut_back, match_date, kick_off, [competition], season_name, home_team, away_team, home_score, away_score, stadium_name, referee_name, matchup, result, is_a_draw, winner, loser, margin_of_victory  from event e 
left join pitchCoordinateValues x on xlocation = x.xlocation_master and ylocation = x.ylocation_master
left join pitchCoordinateValues y on pass_end_xlocation = y.xlocation_master and pass_end_ylocation = y.ylocation_master
where e.event_type = 'Pass'"

event_SQL_query <- function(query){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  result <- dbGetQuery(conn = db, query)
  dbDisconnect(db)
  result
}

pass_SQL_query <- function(){
  result <- event_SQL_query(pass_query)
}



teams_SQL_query <- function(){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  result <- dbGetQuery(db, "select team_name from event group by team_name order by team_name asc")
  dbDisconnect(db)
  result
}

players_SQL_query <- function(){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  result <- dbGetQuery(db, "select player_name, team_name from event where player_name is not null and player_name != '' group by player_name, team_name order by player_name asc")
  dbDisconnect(db)
  result
}






