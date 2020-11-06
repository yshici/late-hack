class ProofOfDelaysController < ApplicationController
  def new
    @delay_info = DelayInfo.new
    @google_maps_api_key = Rails.application.credentials.api_key[:google_maps]
  end

  def create
    delay_info = DelayInfo.new(schedule_params)
    session[:delay_info] = delay_info
    lat, lng = delay_info.lat_lng.delete("()").split(/,/)

    open_weather_api_key = Rails.application.credentials.api_key[:open_weather]
    open_weather_url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{ lat.to_f }&lon=#{ lng.to_f }&exclude=hourly,daily&units=metric&lang=ja&appid=#{ open_weather_api_key }"

    require "json"
    require "open-uri"

    response = open(open_weather_url)
    result_weather = JSON.parse(response.read)
    puts result_weather
    session[:weather] = result_weather["current"]["weather"][0]["description"]

    train_delay_url = "https://tetsudo.rti-giken.jp/free/delay.json"

    require "json"
    require "open-uri"

    response = open(train_delay_url)
    train_delay = JSON.parse(response.read)
    puts train_delay
    name_train_delay = []
    train_delay.map do |t|
      name_train_delay << t["name"]
    end
    session[:name_train_delay] = name_train_delay
    redirect_to proof_of_delays_path
  end

  def show
    @delay_info = session[:delay_info]
    @weather = session[:weather]
    @name_train_delay = session[:name_train_delay]
  end


private

  def schedule_params
    params.require(:delay_info).permit(:name, :destination, :lat_lng, :current_location, :meeting_time)
  end
end