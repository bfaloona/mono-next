require 'rake/testtask'
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

output_yml_file = 'test/fixtures/monologues.yml'

desc "Export some monologues from DB to #{output_yml_file}"
task :export_monos do

  puts "##########################################"
  puts "USING Environment: #{Padrino.env}"
  puts "##########################################"

  # dump db to yaml
  monologues = Monologue.all

  monos_to_keep = []
  %w[Comedy History Tragedy].each do |classification|
    puts "CLASSIFICATION: #{classification}"
    plays = Play.where(classification: classification)
    plays[2..4].each do |play|
      puts "\tPLAY: #{play.title} (#{play.id})"
      monologues = Monologue.where(play: play).order(first_line: :asc)
      monologues[10..12].each do |monologue|
        puts "\t\t MONOLOGUE: #{monologue.first_line} (#{monologue.id})"
        monos_to_keep.push JSON.parse(monologue.to_json).reject {|k,v| [:created_at, :updated_at].include? k.to_sym}
      end
    end

  end

  File.write( Padrino.root + '/test/fixtures/monologues.yml', monos_to_keep.to_yaml)

  puts "##########################################"
  puts "#{monos_to_keep.count} Monologues written to #{output_yml_file}"
  puts "##########################################"

end

