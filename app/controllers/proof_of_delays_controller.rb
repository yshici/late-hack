class ProofOfDelaysController < ApplicationController
  def new
    @delay_info = DelayInfo.new
    @google_maps_api_key = Rails.application.credentials.api_key[:google_maps]
  end

  def create
    @delay_info = DelayInfo.new(schedule_params)


  end

  def show
    # require 'uri'
    # require 'net/http'
    # require 'openssl'

    # url = URI("https://weather2020-weather-v1.p.rapidapi.com/zip/e8ecee8ff60c478f8a36280fea0524fe/1920073")

    # http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # request = Net::HTTP::Get.new(url)
    # request["x-rapidapi-host"] = 'weather2020-weather-v1.p.rapidapi.com'
    # request["x-rapidapi-key"] = '1812cc7b94mshf09ff39441c8af9p1ff243jsn97878fc23e0a'

    # response = http.request(request)
    # puts response.read_body


    open_weather_api_key = Rails.application.credentials.api_key[:open_weather]
    # base_url = "http://api.openweathermap.org/data/2.5/forecast"
    # binding.pry
    base_url = "https://api.openweathermap.org/data/2.5/onecall?lat=35.6581&lon=139.7017&exclude=hourly,daily&appid=#{ open_weather_api_key }"

    require "json"
    require "open-uri"

    # response = open(base_url + "?q=Akashi-shi,jp&APPID=#{api_key}")
    response = open(base_url)
    # binding.pry
    # result_weather = JSON.pretty_generate(JSON.parse(response.read))
    result_weather = JSON.parse(response.read)
    puts result_weather

    # binding.pry
  end


private

  def schedule_params
    params.require(:delay_info).permit(:name, :destination, :longitude_latitude, :current_location, :meeting_time)
  end
end