#!/usr/bin/env ruby
# purpose: run besside-ng on a wlan interface
# relies on the aircrack-ng package

#if_wlan = ARGV[0] || 'wlan0'
if_mon = ARGV[0] || `list_monitoring`.chomp
dir_scripts = File.expand_path File.dirname(__FILE__)
dir_output = "#{dir_scripts}/../log"
Dir.mkdir dir_output unless Dir.exists? dir_output
Dir.chdir dir_output

cmd_besside =<<-eoc
  sudo besside-ng #{if_mon}
eoc
system cmd_besside
