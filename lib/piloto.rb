# purpose: piloto core
require 'json'

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
