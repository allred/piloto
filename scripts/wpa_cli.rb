#!/usr/bin/env ruby
require 'bundler/setup'
require 'wpa_cli_ruby'
$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'piloto'
# TODO:
# - need to cleanup junk
# 1. go through known networks, ignore ones with psk, delete if they don't answer
# -- what if "current" is a dead linksys trap
# -- will a wpa_supplicant reconfigure blow away our mon interface?
# - see todo in the code
# scan
# from the github docs:
# scan_results
# add_network # this will return a network ID
# set_network ID ssid "whateverssid"
# set_network ID psk "password"

@wpa = WpaCliRuby::WpaCli.new
@report = []

# purpose: return a list of ssid structs that could be probed/associated to

def scan_for_open 
  ssids_open = []
  response = @wpa.scan
  count_no_ssid = 0
  count_scanned = 0
  count_skipped = 0
  count_wpa = 0

  @wpa.scan_results.each do |r|
    count_scanned += 1
    # TODO:
    # - figure out how to add networks without an ssid
    # - maybe have a global regex like Officejet for ignoring ssids
    unless r.ssid
      count_no_ssid += 1
      next
    end
    if Wpa.is_ssid_current(r.ssid) 
      #@report.push [curr: [r.bssid, r.ssid, r.flags]]
      next
    end
    unless r.flags == '[ESS]'
      count_wpa += 1
      next
    end
    ssids_open.push(r)
  end
  @report.unshift "#{Time.now} wpa:#{count_wpa} hid:#{count_no_ssid}  / #{count_scanned}"
  return ssids_open
end

ssid_current = Wpa.list_ssid_current
@report.push [curr: [ssid_current.ssid, ssid_current.flags]]
scan_for_open.each do |o|
  @report.push [open: [o.bssid, o.ssid, o.flags]] 
end
puts @report
