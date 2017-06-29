#!/usr/bin/env ruby
require_relative '../../environment'
class CreateGeolocator < ActiveRecord::Migration[5.0]
  def up
    create_table :geolocator do |t|
      t.jsonb :data
      t.column :tstamp, "timestamp with time zone"
    end
    #add_index :geolocator, :data, using: :gin
    add_index :geolocator, :data, unique: true
  end
  def down
    drop_table :geolocator
  end
end
CreateGeolocator.migrate(ARGV[0])
