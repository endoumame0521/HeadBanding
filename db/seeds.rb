# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'zip'

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