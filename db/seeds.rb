# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Prefecture.blank? && City.blank?
  require "csv"
  require "zip"

  PREF_CITY_URL = "http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
  SAVEDIR = "db/"
  CSVROW_PREFNAME = 6
  CSVROW_CITYNAME = 7
  save_path = ""

  # 都道府県・市区町村ZIPを解凍しCSVとして保存
  open(URI.escape(PREF_CITY_URL)) do |file|
    ::Zip::File.open_buffer(file.read) do |zf|
      zf.each do |entry|
        save_path = SAVEDIR + entry.name
        zf.extract(entry, save_path) { true }
      end
    end
  end

  # 都道府県・市区町村CSVを読み込みテーブルに保存
  CSV.foreach(save_path, encoding: "Shift_JIS:UTF-8") do |row|
    pref_name = row[CSVROW_PREFNAME]
    city_name = row[CSVROW_CITYNAME]
    pref = Prefecture.find_or_create_by(:name => pref_name)
    City.find_or_create_by(:name => city_name, prefecture_id: pref.id)
  end

  # 保存したCSVファイルを削除
  File.unlink save_path
end


#初期データを下記する
Admin.create!(
   email: ENV["ADMIN_PASS"],
   password: ENV["ADMIN_MAIL"]
)

[
  ["a@a", "aaaaaa", "田中太郎", "male", "Sun, 07 Feb 1999", "兵庫県", "赤穂市", "はじめまして", "true"],
  ["b@b", "bbbbbb", "斎藤飛鳥", "female", "Mon, 11 Jan 1993", "大阪府", "枚方市", "よろしくお願いします", "true"],
  ["c@c", "cccccc", "遠藤章造", "male", "Fri, 23 Mar 2001", "埼玉県", "朝霧市", "こんにちは", "true"],
  ["d@d", "dddddd", "高嶺美穂", "female", "Sat, 26 Aug 1989", "神奈川県", "横浜市", "どういたしまして", "true"],
  ["e@e", "eeeeee", "佐々木蔵之介", "male", "Mon, 01 Sep 1975", "福岡県", "博多市", "ナイストゥミーチュー", "false"]
].each do |a, b, c, d, e, f, g, h, i|
  Member.create!(
    [
      {
        email: a,
        password: b,
        name: c,
        gender: d,
        birthday: e,
        address_prefecture: f,
        address_city: g,
        introduction: h,
        status: i
      }
    ]
  )
end

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