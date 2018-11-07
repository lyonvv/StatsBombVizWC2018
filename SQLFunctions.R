library("dplyr")
library("RSQLite")





db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")


basicFields <-"select id, matchid, [index], period, [timestamp], minute, second, event_type, possession, possession_team_name, play_pattern_name, off_camera, team_name, duration, player_id, player_name, position_name, ylocation, xlocation"
passSource <- " from event where event_type='Pass'"
passFields <- ", pass_recipient_id, pass_recipient_name, pass_length, pass_angle_radians, pass_height, pass_end_xlocation, pass_end_ylocation, pass_type, pass_body_part, pass_outcome, pass_backhe, under_pressure, pass_cross, pass_switch, pass_aerial_won, pass_deflected, pass_miscommunication, pass_assisted_shot_id, pass_goal_assist, pass_shot_assist, pass_through_ball, pass_cut_back"
matchFields <- ", match_date, kick_off, [competition], season_name, home_team, away_team, home_score, away_score, stadium_name, referee_name, matchup, result, is_a_draw, winner, loser, margin_of_victory"

eventSQLquery <- function(fields, source){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  passes <- dbGetQuery(conn = db, paste(basicFields, fields, matchFields, source, sep=""))
  dbDisconnect()
  }


passes <- eventSQLquery(passFields, passSource)

pitchValuesSQLQuery <- function(){
  db <- dbConnect(SQLite(), dbname="~/sqlite/statsBombData.db")
  dbGetQuery(db, "select * from pitchCoordinateValues")
  dbDisconnect()
}


