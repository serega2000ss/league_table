require './matches.rb'
class LeagueTable
  TEAM_METRICS = [:points, :goals_for, :goals_against, :goal_difference, :wins, :draws, :losses]

  def initialize()
    @matches = Matches.new([], self)
    @teams = {}
  end

  def matches
    @matches
  end

  def update_team_info(match_data)
    team1 = match_data.keys.first
    score1 = match_data.values.first
    team2 = match_data.keys.last
    score2 = match_data.values.last

    update_team(team1, score1, score2)
    update_team(team2, score2, score1)
  end

  def update_team(team, scored, conceded)
    init_team(team)

    inc_feields(team, {losses: 1}) if scored < conceded
    inc_feields(team, {points: 1, draws: 1}) if scored == conceded
    inc_feields(team, {points: 3, wins: 1}) if scored > conceded
    inc_feields(team, {goals_for: scored})
    inc_feields(team, {goals_against: conceded})
    inc_feields(team, {goal_difference: (scored - conceded)})
  end

  TEAM_METRICS.each do |metric|
    define_method("get_#{metric}".to_sym) do |team|
      team.capitalize!
      @teams[team]? @teams[team][metric] : 0
    end
  end


  private

    def init_team(team)
      unless @teams[team]
        @teams[team] = {}
        TEAM_METRICS.each{ |tm| @teams[team][tm] = 0 }
      end
    end

    def inc_feields(team, fields)
      if @teams[team]
        fields.each_pair do |feild, value|
          @teams[team][feild] += value if @teams[team][feild]
        end
      end

    end

end