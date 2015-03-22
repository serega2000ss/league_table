class Matches
  def initialize(matches, league_table)
    @matches_list = matches
    @league_table = league_table
  end

  def push(match)
    if valid?(match)
      @matches_list.push(match)
      @league_table.update_team_info(parse(match))
    end
  end


  private
    def valid?(match)
      match =~ /\A\D*\s*\d+\s*-{1}\s*\d+\s*\D*\z/
    end

    def parse(match)
      team1 = match.scan(/\A\D+\s*/).first.strip.capitalize
      score1 = match.scan(/(\d+)/).first.first.to_i

      team2 = match.scan(/\s\D+$/).first.strip.capitalize
      score2 = match.scan(/(\d+)/).last.first.to_i

      { team1 => score1, team2 => score2 }
    end
end