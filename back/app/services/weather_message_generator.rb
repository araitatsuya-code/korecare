module WeatherMessageGenerator
  def self.generate_message(prefecture_name, weather_info)
    text = "おはようございます！\n今日の#{prefecture_name}の天気情報をお届けします✉️\n\n"
    text += "☀️現在のUV指数は#{weather_info[:current_uvi]}、最高UV指数は#{weather_info[:daily_max_uvi]}です。\n"
    text += uv_index_advice(weather_info[:current_uvi], weather_info[:daily_max_uvi])
    text += "✔︎UV指数は、1〜2が「弱い」、3〜5が「中程度」、6以上が「強い」といわれています。\n\n"
    text += "💧現在の湿度は#{weather_info[:current_humidity]}%、最低湿度は#{weather_info[:daily_min_humidity]}%です。\n"
    text += humidity_advice(weather_info[:current_humidity], weather_info[:daily_min_humidity])
    text += "✔︎お肌に最適な湿度は、50〜60%といわれています。\n\n"
    text += "この情報が少しでも皆さんのお役に立ちますように。\n"
    text += "今日もKoreCareをご利用いただき、ありがとうございます。"
  end

  def self.uv_index_advice(current_uvi, daily_max_uvi)
    return "UV指数情報が利用できません。" if current_uvi.nil? || daily_max_uvi.nil?

    if current_uvi >= 6
      "現在UV指数が高いです。日焼けを防ぐために日傘や日焼け止めの利用、長袖や帽子の着用をお勧めします。\n"
    elsif current_uvi.between?(3, 5)
      "現在UV指数は中程度です。日焼けを防ぐために日傘や日焼け止めの利用、長袖や帽子の着用をお勧めします。\n"
    elsif daily_max_uvi >= 6
      "また、これからUV指数が高くなる予報が出ています。日焼けを防ぐために日傘や日焼け止めの利用、長袖や帽子の着用をお勧めします。\n"
    else
      "UV指数は通常範囲内です。\n\n"
    end
  end

  def self.humidity_advice(current_humidity, daily_min_humidity)
    return "湿度情報が利用できません。" if current_humidity.nil? || daily_min_humidity.nil?

    if current_humidity <= 30 || daily_min_humidity <= 30
      "現在空気が乾燥しています。ミスト化粧水やクリームを活用して、適宜うるおいを補給することをお勧めします。\n"
    elsif current_humidity.between?(30, 50)
      "現在空気がやや乾燥しています。ミスト化粧水やクリームを活用して、適宜うるおいを補給することをお勧めします。\n"
    elsif daily_min_humidity < 50
      "また、最低湿度が50%を下回る予報が出ています。お肌の乾燥が気になった際はミスト化粧水やクリームを活用して、適宜うるおいを補給することをお勧めします。\n\n"
    else
      "現在湿度は通常範囲内ですが、お肌の乾燥が気になった際はミスト化粧水やクリームを活用して、うるおいを補給することをお勧めします。\n"
    end
  end
end
