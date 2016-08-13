#!/usr/bin/env ruby
# purpose: run airmon-ng 
# relies on the aircrack-ng package
require 'open3'

dir_scripts = File.expand_path File.dirname(__FILE__)
device_monitorable = `#{dir_scripts}/list_monitorable`.split("\n")
if_wlan = ARGV[0] || device_monitorable[0]
# TODO: output should go to <gitrepodir>/tmp or log
dir_output = '/home/pi/besside'
Dir.mkdir dir_output unless Dir.exists? dir_output
Dir.chdir dir_output

interfaces_wlan = []
cmd_list_interfaces = 'ip link show | grep wlan'
stdout_li, stderr_li, status_li = Open3.capture3(cmd_list_interfaces)
stdout_li.split("\n").each do |l|
  m = /(wlan\d+)/.match(l)
  #puts [LINE: m[0]]
  interfaces_wlan.push(m[0])
end
cmd_ifdown = ''
cmd_ifup = ''
interfaces_wlan.each do |i|
  next if i == if_wlan
  #cmd_ifdown += "ifdown #{i};"
  cmd_ifdown += "ip link set dev #{i} down;"
  #cmd_ifup += "ifup #{i};"
  cmd_ifup += "ip link set dev #{i} up;"
end
puts [DEBUG: cmd_ifdown]
cmd_airmon_start =<<-eoc
  nohup sudo bash -c "#{cmd_ifdown} airmon-ng start #{if_wlan}; #{cmd_ifup}"
eoc
puts cmd_airmon_start
system cmd_airmon_start
