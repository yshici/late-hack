class ApiGet
  require "json"
  require "open-uri"

  def weather(lat, lng)
    # open weather api取得
    open_weather_api_key = Rails.application.credentials.api_key[:open_weather]
    open_weather_url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{ lat }&lon=#{ lng }&exclude=hourly,daily&units=metric&lang=ja&appid=#{ open_weather_api_key }"
    response_weather = open(open_weather_url)
    result_weather = JSON.parse(response_weather.read)
    get_weather = result_weather["current"]["weather"][0]["description"]
    return get_weather
  end

  def train
     # 鉄道遅延情報 api取得
     train_delay_url = "https://tetsudo.rti-giken.jp/free/delay.json"
     response_train = open(train_delay_url)
     train_delay = JSON.parse(response_train.read)
     puts train_delay
     name_train_delay = []
     train_delay.map do |t|
       name_train_delay << t["name"]
     end
     return name_train_delay
  end

  def nhk
    # NHK番組表 api取得
    nhk_program_api_key = Rails.application.credentials.api_key[:nhk_program]
    nhk_program_url = "https://api.nhk.or.jp/v2/pg/now/130/g1.json?key=#{nhk_program_api_key}"
    response_nhk = open(nhk_program_url)
    nhk_program = JSON.parse(response_nhk.read)
    get_nhk = nhk_program["nowonair_list"]["g1"]["previous"]["title"]
    # puts get_nhk
    return get_nhk
  end

  def restaurant(lat, lng)
    # ぐるなび api取得
    restaurant_api_key = Rails.application.credentials.api_key[:restaurant_gurunavi]
    restaurant_url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{restaurant_api_key}&latitude=#{ lat }&longitude=#{ lng }"
    response_restaurant = open(restaurant_url)
    restaurant_gurunavi = JSON.parse(response_restaurant.read)
    # puts restaurant_gurunavi
    get_restaurant = {name: restaurant_gurunavi["rest"][0]["name"], url: restaurant_gurunavi["rest"][0]["url"]}
    return get_restaurant
  end

  def hotel(lat, lng)
    # 楽天トラベル api取得
    rakuten_hotel_api_key = Rails.application.credentials.api_key[:hotel_rakuten]
    rakuten_hotel_url = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=#{ lat }&longitude=#{ lng }&applicationId=#{rakuten_hotel_api_key}"
    response_hotel = open(rakuten_hotel_url)
    hotel_rakuten = JSON.parse(response_hotel.read)
    # puts hotel_rakuten
    get_hotel = {name: hotel_rakuten["hotels"][0]["hotel"][0]["hotelBasicInfo"]["hotelName"], url: hotel_rakuten["hotels"][0]["hotel"][0]["hotelBasicInfo"]["hotelInformationUrl"]}
    return get_hotel
  end
end