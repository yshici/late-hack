class ApiGet
  require "json"
  require "open-uri"
  # require 'news-api'

  def get_api
    # 鉄道遅延情報 api取得
    train_delay_url = "https://tetsudo.rti-giken.jp/free/delay.json"
    begin
      response_train = open(train_delay_url)
      train_delay = JSON.parse(response_train.read)
      name_train_delay = []
      train_delay.map do |t|
        name_train_delay << { name: t["name"], company: t["company"] }
      end
      get = { train: name_train_delay }
      # puts get[:train]
      # 長期運休等も拾っているので消す。たまにチェック必要。
      # 取得元サイト https://www.tetsudo.com/traffic/
      ignore_train = ["小湊鉄道線", "富士急行", "島原鉄道線", "特急ラピート", "特急サザン", "阿武隈急行線"]
      get[:train].delete_if do |train|
        ignore_train.include?(train[:name])
      end
    rescue
      get = { train: nil }
    end

    # NHK番組表 api取得
    nhk_program_api_key = Rails.application.credentials.api_key[:nhk_program]
    nhk_program_url = "https://api.nhk.or.jp/v2/pg/now/130/g1.json?key=#{ nhk_program_api_key }"
    begin
      response_nhk = open(nhk_program_url)
      nhk_program = JSON.parse(response_nhk.read)
      get[:nhk] = { name: nhk_program["nowonair_list"]["g1"]["previous"]["title"] }
    rescue
      get[:nhk] = nil
    end

    # news api取得
    news_api_key = Rails.application.credentials.api_key[:news]
    news_url = "https://newsapi.org/v2/top-headlines?country=jp&apiKey=#{ news_api_key }"
    begin
      response_news = open(news_url)
      news = JSON.parse(response_news.read)
      get_news = []
      news["articles"].first(5).each do |article|
        get_news << { title: article["title"], description: article["description"], url: article["url"], image: article["urlToImage"] }
      end
      get[:news] = get_news
    rescue
      get[:news] = nil
    end
    get
  end

  def get_api_with_position(lat, lng)
    rakuten_api_key = Rails.application.credentials.api_key[:rakuten]
    open_weather_api_key = Rails.application.credentials.api_key[:open_weather]
    restaurant_api_key = Rails.application.credentials.api_key[:restaurant_gurunavi]
    # open weather api取得
    open_weather_url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{ lat }&lon=#{ lng }&exclude=hourly,daily&units=metric&lang=ja&appid=#{ open_weather_api_key }"
    begin
      response_weather = open(open_weather_url)
      result_weather = JSON.parse(response_weather.read)
      get = { weather: { name: result_weather["current"]["weather"][0]["description"] } }
    rescue
      get = { weather: nil }
    end

    # ぐるなび api取得
    restaurant_url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{ restaurant_api_key }&latitude=#{ lat }&longitude=#{ lng }"
    begin
      response_restaurant = open(restaurant_url)
      restaurant_gurunavi = JSON.parse(response_restaurant.read)
      count = restaurant_gurunavi["rest"].length > 3 ? 3 : restaurant_gurunavi["rest"].length
      get_restaurant = []
      restaurant_gurunavi["rest"].first(count).each do |restaurant|
        get_restaurant << { name: restaurant["name"], category: restaurant["category"], url: restaurant["url"], image_url: restaurant["image_url"]["shop_image1"], address: restaurant["address"] }
      end
      get[:restaurant] = get_restaurant
    rescue
      get[:restaurant] = nil
      # 楽天商品ランキングAPI（ハム）取得
      rakuten_ham_url = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?format=json&genreId=100228&applicationId=#{ rakuten_api_key }"
      begin
        response_ham = open(rakuten_ham_url)
        ham_rakuten = JSON.parse(response_ham.read)
        get_ham = []
        ham_rakuten["Items"].first(3).each do |ham|
          get_ham << { name: ham["Item"]["itemName"], url: ham["Item"]["itemUrl"], image_url: ham["Item"]["smallImageUrls"][0]["imageUrl"], price: ham["Item"]["itemPrice"], score: ham["Item"]["reviewAverage"] }
        end
        get[:ham] = get_ham
      rescue
        get[:ham] = nil
      end
    end

    # 楽天トラベル api取得
    rakuten_api_key = Rails.application.credentials.api_key[:rakuten]
    rakuten_hotel_url = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=#{ lat }&longitude=#{ lng }&applicationId=#{ rakuten_api_key }"
    begin
      response_hotel = open(rakuten_hotel_url)
      hotel_rakuten = JSON.parse(response_hotel.read)
      count = hotel_rakuten["hotels"].length > 3 ? 3 : hotel_rakuten["hotels"].length
      get_hotel = []
      hotel_rakuten["hotels"].first(count).each do |hotel|
        get_hotel << { name: hotel["hotel"][0]["hotelBasicInfo"]["hotelName"], url: hotel["hotel"][0]["hotelBasicInfo"]["hotelInformationUrl"], image_url: hotel["hotel"][0]["hotelBasicInfo"]["hotelImageUrl"], address1: hotel["hotel"][0]["hotelBasicInfo"]["address1"], address2: hotel["hotel"][0]["hotelBasicInfo"]["address2"] }
      end
      get[:hotel] = get_hotel
    rescue
      get[:hotel] = nil
      # 楽天商品ランキングAPI（テント）取得
      rakuten_tent_url = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?format=json&genreId=302373&applicationId=#{ rakuten_api_key }"
      begin
        response_tent = open(rakuten_tent_url)
        tent_rakuten = JSON.parse(response_tent.read)
        get_tent = []
        tent_rakuten["Items"].first(3).each do |tent|
          get_tent << { name: tent["Item"]["itemName"], url: tent["Item"]["itemUrl"], image_url: tent["Item"]["smallImageUrls"][0]["imageUrl"], price: tent["Item"]["itemPrice"], score: tent["Item"]["reviewAverage"] }
        end
        get[:tent] = get_tent
      rescue
        get[:tent] = nil
      end
    end
    get
  end
end
