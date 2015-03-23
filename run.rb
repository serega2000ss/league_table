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


lt = LeagueTable.new

lt.matches.push("Man Utd 3 - 0 Liverpool")

puts lt.get_goals_for("Man Utd")
puts lt.get_points("Man Utd")
puts lt.get_points("Liverpool")
puts lt.get_goal_difference("Liverpool")

lt.matches.push("Liverpool 1 - 1 Man Utd")

puts lt.get_goals_for("Man Utd")
puts lt.get_points("Man Utd")
puts lt.get_points("Liverpool")
puts lt.get_goals_against("Man Utd")

puts lt.get_points("Tottenham")


puts 'lt ========================================'
puts lt.inspect
puts '==========================================='


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
    end

    # it 'properly transforms teams names' do
    # end

  end

end
