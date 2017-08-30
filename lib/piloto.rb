# purpose: piloto core
require 'bundler/setup'
require 'json'
require 'net/http'
require 'net/https'
require 'syslog/logger'
require 'uri'
require 'wpa_cli_ruby'

module Google
  @url_google_geo = "https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['PILOTO_GOOGLE_MAPS_API_KEY']}"

  def Google.geolocate(payload, headers)
    response = nil
    begin
      response = RestClient.post(@url_google_geo, payload.to_json, headers)
      return response
    rescue RestClient::ExceptionWithResponse => e
      return e.response
    end
  end
end

module Slack
  @url_webhook = ENV['PILOTO_SLACK_WEBHOOK_URL']

  def Slack.send_payload(args)
    uri = URI.parse(args[:url_webhook])
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    http_verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(args[:url_webhook])
    req.set_form_data({payload: args[:payload]})
    http.request(req)
  end
end

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
  @host_ping = ENV['PILOTO_HOST_PING'] || 'google.com'
  @log = Syslog::Logger.new File.basename($0)

  def self.cpu_temp
    temp_f = File.read('/sys/class/thermal/thermal_zone0/temp').chomp.to_i / 1000 + 32
    temp_f *= (9.0 / 5.0)
    temp_f = sprintf("%.0f", temp_f)
  end

  def self.dir_log
    dir_lib = File.expand_path File.dirname(__FILE__)
    "#{dir_lib}/../log"
  end

  def self.dir_scripts
    dir_lib = File.expand_path File.dirname(__FILE__)
    "#{dir_lib}/../scripts"
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

  def self.hostid
    `cat /etc/machine-id`.chomp[0..7] || `hostid`.chomp
  end

  def self.hostname
    `hostname`.chomp
  end

  def self.logger
    @log
  end

  # use system ping to send ICMP, ignore stdout
  # return the Process::Status object

  def self.ping
    _ = `ping -c 1 #{@host_ping} > /dev/null 2>&1`
    return $?
  end

end
