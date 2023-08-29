# Load in shots data and store as shot data variable
shot_data = read.csv("/Users/davidzack/Desktop/Thunder_Assessment/shots_data.csv")

# Create linear distance from the hoop column to determine three pointers
shot_data$distance = sqrt(shot_data$x^2 + shot_data$y^2)
# Create corner three column to identify corner threes
shot_data$corner_three = abs(shot_data$x) > 22.0 & shot_data$y <= 7.8
# Create non-corner three column to identify non-corner threes
shot_data$noncorner_three = shot_data$distance > 23.75 & shot_data$corner_three == FALSE
# Create two point column to identify two pointers
shot_data$two_point = shot_data$distance <= 23.75 & shot_data$corner_three == FALSE

# Summarize shots for Team A
team_a = shot_data[shot_data$team == "Team A",]

team_a_summary = data.frame(efg_2pt = sum(team_a[team_a$two_point == TRUE,c("fgmade")])/nrow(team_a[team_a$two_point == TRUE,]),
                            efg_c3 = 1.5*sum(team_a[team_a$corner_three == TRUE,c("fgmade")])/nrow(team_a[team_a$corner_three == TRUE,]),
                            efg_nc3 = 1.5*sum(team_a[team_a$noncorner_three == TRUE,c("fgmade")])/nrow(team_a[team_a$noncorner_three == TRUE,]),
                            corner_threes = nrow(team_a[team_a$corner_three == TRUE,])/nrow(team_a),
                            noncorner_threes = nrow(team_a[team_a$noncorner_three == TRUE,])/nrow(team_a),
                            two_pointers = nrow(team_a[team_a$two_point == TRUE,])/nrow(team_a))

# Summarize shots for Team B
team_b = shot_data[shot_data$team == "Team B",]

team_b_summary = data.frame(efg_2pt = sum(team_b[team_b$two_point == TRUE,c("fgmade")])/nrow(team_b[team_b$two_point == TRUE,]),
                            efg_c3 = 1.5*sum(team_b[team_b$corner_three == TRUE,c("fgmade")])/nrow(team_b[team_b$corner_three == TRUE,]),
                            efg_nc3 = 1.5*sum(team_b[team_b$noncorner_three == TRUE,c("fgmade")])/nrow(team_b[team_b$noncorner_three == TRUE,]),
                            corner_threes = nrow(team_b[team_b$corner_three == TRUE,])/nrow(team_b),
                            noncorner_threes = nrow(team_b[team_b$noncorner_three == TRUE,])/nrow(team_b),
                            two_pointers = nrow(team_b[team_b$two_point == TRUE,])/nrow(team_b))
