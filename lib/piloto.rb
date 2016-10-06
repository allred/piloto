# purpose: piloto core
require 'json'
require 'wpa_cli_ruby'

module Wpa
  @wpa = WpaCliRuby::WpaCli.new

  def Wpa.is_ssid_current(ssid)
    is_current = false
    @wpa.list_networks.each do |n|
      if n.ssid == ssid
        if n.flags == '[CURRENT]'
          is_current = true
        end
      end
    end
    return is_current
  end
end

class Piloto
  def self.testes
    puts @wpa
  end

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
