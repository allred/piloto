#!/usr/bin/env ruby
# purpose: run besside-ng on a wlan interface
# relies on the aircrack-ng package

if_wlan = 'wlan0'
if_mon = 'mon0'
dir_output = '/home/pi/besside'
Dir.mkdir dir_output unless Dir.exists? dir_output
Dir.chdir dir_output
cmd_airmon_start =<<-eoc
  nohup sudo bash -c "ifdown wlan1; ifdown wlan2; airmon-ng start #{if_wlan}; ifup wlan1; ifup wlan2"
eoc
  #nohup sudo bash -c "ifdown wlan0; ifdown wlan2; airmon-ng start #{if_wlan}; ifup wlan0; ifup wlan2"
system cmd_airmon_start

cmd_besside =<<-eoc
  sudo /usr/sbin/besside-ng #{if_mon}
eoc
system cmd_besside
