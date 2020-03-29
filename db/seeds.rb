# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Prefecture.blank? && City.blank?
  require "csv"

  # 都道府県・市区町村CSVを読み込みテーブルに保存
  CSV.foreach("db/KEN_ALL.CSV", encoding: "Shift_JIS:UTF-8") do |row|
    pref_name = row[6]
    city_name = row[7]
    pref = Prefecture.find_or_create_by(:name => pref_name)
    City.find_or_create_by(:name => city_name, prefecture_id: pref.id)
  end
end


#初期データを下記する
Admin.create!(
   email: ENV["ADMIN_MAIL"],
   password: ENV["ADMIN_PASS"]
)


[
  ["ロック", "true"],
  ["ポップス", "true"],
  ["パンク", "true"],
  ["メタル", "false"],
  ["ファンク", "true"],
  ["ジャズ", "true"],
  ["R&B", "false"],
  ["ラウドロック", "true"],
  ["EDM", "true"],
  ["エレクトロニコア", "true"]
].each do |a, b|
  Genre.create!(
    [
      {
        name: a,
        status: b
      }
    ]
  )
end

[
  ["ギター", "true"],
  ["ベース", "true"],
  ["ドラム", "true"],
  ["キーボード", "false"],
  ["ボーカル", "true"],
  ["尺八", "true"],
  ["バイオリン", "false"],
  ["オルガン", "true"],
  ["シンセサイザー", "false"],
  ["和太鼓", "true"],
  ["ピアノ", "true"]
].each do |a, b|
  Part.create!(
    [
      {
        name: a,
        status: b
      }
    ]
  )
end