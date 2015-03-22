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
lt.matches.push("Man Utd 3 --- 0 Liverpool")


puts 'lt ========================================'
puts lt.inspect
puts '==========================================='


describe LeagueTable do

  # your specs 

end
