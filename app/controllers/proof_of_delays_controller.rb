class ProofOfDelaysController < ApplicationController
  skip_before_action :require_login
  def new
    @delay_info = DelayInfo.new
    @google_maps_api_key = Rails.application.credentials.api_key[:google_maps]
  end

  def create
    delay_info = DelayInfo.new(schedule_params)
    session[:delay_info] = delay_info
    lat, lng = delay_info.destination_lat_lng.delete("()").split(/,/)

    # open weather api取得
    open_weather_api_key = Rails.application.credentials.api_key[:open_weather]
    open_weather_url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{ lat.to_f }&lon=#{ lng.to_f }&exclude=hourly,daily&units=metric&lang=ja&appid=#{ open_weather_api_key }"

    require "json"
    require "open-uri"

    response_weather = open(open_weather_url)
    result_weather = JSON.parse(response_weather.read)
    puts result_weather
    session[:weather] = result_weather["current"]["weather"][0]["description"]


    # 鉄道遅延情報 api取得
    train_delay_url = "https://tetsudo.rti-giken.jp/free/delay.json"

    require "json"
    require "open-uri"

    response_train = open(train_delay_url)
    train_delay = JSON.parse(response_train.read)
    puts train_delay
    name_train_delay = []
    train_delay.map do |t|
      name_train_delay << t["name"]
    end
    session[:name_train_delay] = name_train_delay

    # NHK番組表 api取得
    nhk_program_api_key = Rails.application.credentials.api_key[:nhk_program]
    nhk_program_url = "https://api.nhk.or.jp/v2/pg/now/130/g1.json?key=#{nhk_program_api_key}"

    require "json"
    require "open-uri"

    response_nhk = open(nhk_program_url)
    nhk_program = JSON.parse(response_nhk.read)
    puts nhk_program


    redirect_to proof_of_delays_path
  end

  def show
    @delay_info = session[:delay_info]
    @weather = session[:weather]
    @name_train_delay = session[:name_train_delay]
  end


private

  def schedule_params
    params.require(:delay_info).permit(:name, :destination_name, :destination_lat_lng, :destination_address, :current_location, :meeting_time)
  end
end