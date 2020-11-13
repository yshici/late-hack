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
    nhk = nhk_program["nowonair_list"]["g1"]["previous"]["title"]
    puts nhk

    # ぐるなび api取得
    restaurant_api_key = Rails.application.credentials.api_key[:restaurant_gurunavi]
    restaurant_url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{restaurant_api_key}&latitude=35.6581&longitude=139.7017"

    require "json"
    require "open-uri"

    response_restaurant = open(restaurant_url)
    restaurant_gurunavi = JSON.parse(response_restaurant.read)
    puts restaurant_gurunavi
    get_restaurnt_info = restaurant_gurunavi["rest"][0]["name"]
    get_restaurnt_url = restaurant_gurunavi["rest"][0]["url"]

    # 楽天トラベル api取得
    rakuten_hotel_api_key = Rails.application.credentials.api_key[:hotel_rakuten]
    rakuten_hotel_url = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=35.6581&longitude=139.7017&applicationId=#{rakuten_hotel_api_key}"

    require "json"
    require "open-uri"

    response_hotel = open(rakuten_hotel_url)
    hotel_rakuten = JSON.parse(response_hotel.read)
    puts hotel_rakuten
    # binding.pry

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

