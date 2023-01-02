
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

# Require the 'rake/testtask' gem
require 'rake/testtask'

# Require the file located in the config/boot directory
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

# Set the output yml file
output_yml_file = 'test/fixtures/monologues.yml'

# Describe the task and set the output file
desc "Export some monologues from DB to #{output_yml_file}"
task :export_monos do

  # Display the environment
  puts "##########################################"
  puts "USING Environment: #{Padrino.env}"
  puts "##########################################"

  # Get the monologues from the db
  monologues = Monologue.all

  # Create an array to store the monologues
  monos_to_keep = []

  # Iterate through the classifications
  %w[Comedy History Tragedy].each do |classification|
    puts "CLASSIFICATION: #{classification}"

    # Get the plays from the db
    plays = Play.where(classification: classification)

    # Iterate through the plays
    plays[2..4].each do |play|
      puts "\tPLAY: #{play.title} (#{play.id})"

      # Get the monologues from the db
      monologues = Monologue.where(play: play).order(first_line: :asc)

      # Iterate through the monologues
      monologues[10..12].each do |monologue|
        puts "\t\t MONOLOGUE: #{monologue.first_line} (#{monologue.id})"

        # Add the monologue to the array
        monos_to_keep.push JSON.parse(monologue.to_json).reject {|k,v| [:created_at, :updated_at].include? k.to_sym}
      end
    end

  end

  # Write the monologues to the yml file
  File.write( Padrino.root + '/test/fixtures/monologues.yml', monos_to_keep.to_yaml)

  # Display the number of monologues written
  puts "##########################################"
  puts "#{monos_to_keep.count} Monologues written to #{output_yml_file}"
  puts "##########################################"

end