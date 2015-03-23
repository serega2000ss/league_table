class Matches
  def initialize(league_table)
    @matches_list = []
    @league_table = league_table
  end

  def push(match)
    if valid?(match)
      @matches_list.push(match)
      @league_table.update_team_info(parse(match))
    end
  end

  def clear
    @matches_list = []
    @league_table.teams = {}
  end

  private

    def valid?(match)
      match =~ /\A\D+\S+\s*\d+\s*-{1}\s*\d+\s*\S+\D+\z/
    end

    def parse(match)
      team1 = match.scan(/\A\D+\s*/).first.strip.capitalize.squeeze(' ')
      score1 = match.scan(/(\d+)/).first.first.to_i

      team2 = match.scan(/\s\D+$/).first.strip.capitalize.squeeze(' ')
      score2 = match.scan(/(\d+)/).last.first.to_i

      [team1, score1, team2, score2]
    end

end