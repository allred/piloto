# purpose: piloto core
require 'bundler/setup'
require 'json'
require 'wpa_cli_ruby'

module Wpa
  @wpa = nil 
  @flag_current = '[CURRENT]'

  def Wpa.is_ssid_current(ssid)
    is_current = false
    wpa.list_networks.each do |n|
      if n.ssid == ssid
        if n.flags == @flag_current 
          is_current = true
        end
      end
    end
    return is_current
  end

  def Wpa.list_ssid_current
    ssid = nil
    wpa.list_networks.each do |n|
      if n.flags == @flag_current 
        ssid = n
      end
    end
    return ssid
  end

  def Wpa.wpa
     unless @wpa
       @wpa = WpaCliRuby::WpaCli.new
     end
     @wpa
  end

end

class Piloto

  # purpose: returns an array of hashes representing an airodump gps file

  def self.gps_to_array(path_file_gps)
    string_gps_raw = File.read(path_file_gps)
    string_gps_raw.gsub!(/\r\r?/, "\n")

    output = []
    string_gps_raw.each_line do |line|
      h = {}
      begin
        h = JSON.parse(line)
        parsed = true
      rescue
      end
      if parsed
        #puts [DEBUG: h]
        output.push h
      end
    end
    return output
  end

end
