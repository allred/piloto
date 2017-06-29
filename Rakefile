# http://exposinggotchas.blogspot.com/2011/02/activerecord-migrations-without-rails.html
require 'active_record'
require 'logger'
require 'rake/testtask'
require 'yaml'

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

task :profile do
  # dot seems hella broken via homebrew, not using it for now
  #system "ruby-prof --mode=wall --printer=dot --file=profile.dot scripts/gen_kml_gps go && dot -T pdf -o profile.pdf profile.dot && open profile.pdf"
  system "ruby-prof --mode=wall --printer=flat_with_line_numbers --file=profile.txt scripts/geo_cluster genkml -- --limit-waypoints 10000 2>/dev/null"
end

namespace :db do
  task :environment do
    DATABASE_ENV = ENV['DATABASE_ENV'] || 'development'
    MIGRATIONS_DIR = ENV['MIGRATIONS_DIR'] || 'db/migrate'
  end

  task :configuration => :environment do
    @config = YAML.load_file('config/databases.yml')[DATABASE_ENV]
  end

  task :configure_connection => :configuration do
    ActiveRecord::Base.establish_connection @config
    ActiveRecord::Base.logger = Logger.new STDOUT if @config['logger']
  end

  desc 'Migrate the database (options: VERSION=x, VERBOSE=false).'
  task :migrate => :configure_connection do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate MIGRATIONS_DIR, ENV['VERSION'] ? ENV['VERSION'].to_i : nil
  end
end
