# system 'rm Gemfile' if File.exist?('Gemfile')
# File.write('Gemfile', <<-GEMFILE)
#   source 'https://rubygems.org'
# GEMFILE

system 'bundle install'

require 'bundler'
Bundler.setup(:default)

require 'minitest/autorun'
require 'logger'

require './league_table.rb'


describe LeagueTable do

  before do
    @league_table = LeagueTable.new
  end

  describe 'matches#push' do
    it 'does not accept wrong data' do
      @league_table.matches.push('Man Utd 3 -')
      @league_table.teams.count.must_equal 0

      @league_table.matches.push(' 0 - 2 Liverpool')
      @league_table.teams.count.must_equal 0

      @league_table.matches.push('Man Utd - Liverpool')
      @league_table.teams.count.must_equal 0

      @league_table.matches.push('Man Utd 3  0 Liverpool')
      @league_table.teams.count.must_equal 0

      @league_table.matches.push('Man Utd - 0 Liverpool')
      @league_table.teams.count.must_equal 0

      @league_table.matches.push('Man Utd 3 - Liverpool')
      @league_table.teams.count.must_equal 0

      @league_table.matches.push('Man Utd 3 -- 0 Liverpool')
      @league_table.teams.count.must_equal 0

      @league_table.matches.push('Man Utd 3 4 - 0 Liverpool')
      @league_table.teams.count.must_equal 0
    end

    it 'properly transforms teams names' do
      @league_table.matches.push('Man Utd 3 - 0 Liverpool')
      @league_table.teams.count.must_equal 2

      @league_table.get_wins('Man Utd').must_equal 1
      @league_table.get_wins('MAN utd').must_equal 1
      @league_table.get_wins('   man    utd   ').must_equal 1
    end
  end


  describe 'matches#clear' do
    it 'clears all team data' do
      @league_table.matches.push('Man Utd 3 - 0 Liverpool')
      @league_table.teams.count.must_equal 2

      @league_table.matches.clear
      @league_table.teams.count.must_equal 0
    end
  end


  describe '#get_metrics' do
    it 'returns 0 as default value' do
      @league_table.teams.count.must_equal 0

      @league_table.get_points('Liverpool').must_equal 0
      @league_table.get_goals_for('Liverpool').must_equal 0
      @league_table.get_goals_against('Liverpool').must_equal 0
      @league_table.get_goal_difference('Liverpool').must_equal 0
      @league_table.get_wins('Liverpool').must_equal 0
      @league_table.get_draws('Liverpool').must_equal 0
      @league_table.get_losses('Liverpool').must_equal 0
    end

    it 'calculates metrics properly' do
      @league_table.matches.push('Man Utd 4 - 2 Liverpool')

      @league_table.get_points('Man Utd').must_equal 3
      @league_table.get_goals_for('Man Utd').must_equal 4
      @league_table.get_goals_against('Man Utd').must_equal 2
      @league_table.get_goal_difference('Man Utd').must_equal 2
      @league_table.get_wins('Man Utd').must_equal 1
      @league_table.get_draws('Man Utd').must_equal 0
      @league_table.get_losses('Man Utd').must_equal 0

      @league_table.get_points('Liverpool').must_equal 0
      @league_table.get_goals_for('Liverpool').must_equal 2
      @league_table.get_goals_against('Liverpool').must_equal 4
      @league_table.get_goal_difference('Liverpool').must_equal -2
      @league_table.get_wins('Liverpool').must_equal 0
      @league_table.get_draws('Liverpool').must_equal 0
      @league_table.get_losses('Liverpool').must_equal 1

      @league_table.matches.push('Liverpool 1 -  1 Tottenham')

      @league_table.get_points('Liverpool').must_equal 1
      @league_table.get_goals_for('Liverpool').must_equal 3
      @league_table.get_goals_against('Liverpool').must_equal 5
      @league_table.get_goal_difference('Liverpool').must_equal -2
      @league_table.get_wins('Liverpool').must_equal 0
      @league_table.get_draws('Liverpool').must_equal 1
      @league_table.get_losses('Liverpool').must_equal 1

      @league_table.matches.push('Tottenham 2 - 3 Man utd')

      @league_table.get_points('Man Utd').must_equal 6
      @league_table.get_goals_for('Man Utd').must_equal 7
      @league_table.get_goals_against('Man Utd').must_equal 4
      @league_table.get_goal_difference('Man Utd').must_equal 3
      @league_table.get_wins('Man Utd').must_equal 2
      @league_table.get_draws('Man Utd').must_equal 0
      @league_table.get_losses('Man Utd').must_equal 0

      @league_table.get_points('Tottenham').must_equal 1
      @league_table.get_goals_for('Tottenham').must_equal 3
      @league_table.get_goals_against('Tottenham').must_equal 4
      @league_table.get_goal_difference('Tottenham').must_equal -1
      @league_table.get_wins('Tottenham').must_equal 0
      @league_table.get_draws('Tottenham').must_equal 1
      @league_table.get_losses('Tottenham').must_equal 1
    end
  end

end