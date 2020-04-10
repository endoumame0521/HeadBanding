# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_08_132228) do

  create_table "accesses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "visitor_id", null: false
    t.bigint "visited_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["visited_id"], name: "index_accesses_on_visited_id"
    t.index ["visitor_id"], name: "index_accesses_on_visitor_id"
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "announces", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "announcer_id", null: false
    t.integer "reciever_id", null: false
    t.bigint "article_id"
    t.bigint "tweet_id"
    t.bigint "tweet_comment_id"
    t.bigint "message_id"
    t.integer "action", default: 0, null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_announces_on_article_id"
    t.index ["message_id"], name: "index_announces_on_message_id"
    t.index ["tweet_comment_id"], name: "index_announces_on_tweet_comment_id"
    t.index ["tweet_id"], name: "index_announces_on_tweet_id"
  end

  create_table "article_cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_cities_on_article_id"
    t.index ["city_id"], name: "index_article_cities_on_city_id"
  end

  create_table "article_favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_favorites_on_article_id"
    t.index ["member_id"], name: "index_article_favorites_on_member_id"
  end

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.boolean "published_status", default: true, null: false
    t.integer "category", null: false
    t.string "subject", null: false
    t.text "body", null: false
    t.integer "day_of_the_week"
    t.integer "band_intention"
    t.integer "music_intention"
    t.integer "gender"
    t.integer "age_min"
    t.integer "age_max"
    t.string "sound"
    t.integer "band_theme"
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "prefecture_id", null: false
    t.index ["member_id"], name: "index_articles_on_member_id"
    t.index ["prefecture_id"], name: "index_articles_on_prefecture_id"
  end

  create_table "artists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id", null: false
    t.index ["member_id"], name: "index_artists_on_member_id"
  end

  create_table "blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "blocker_id"
    t.bigint "blocked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_id"], name: "index_blocks_on_blocked_id"
    t.index ["blocker_id"], name: "index_blocks_on_blocker_id"
  end

  create_table "cities", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 16, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "prefecture_id"
    t.index ["prefecture_id"], name: "index_cities_on_prefecture_id"
  end

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_entries_on_member_id"
    t.index ["room_id"], name: "index_entries_on_room_id"
  end

  create_table "genre_articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_genre_articles_on_article_id"
    t.index ["genre_id"], name: "index_genre_articles_on_genre_id"
  end

  create_table "genre_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_members_on_genre_id"
    t.index ["member_id"], name: "index_genre_members_on_member_id"
  end

  create_table "genres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.integer "gender", null: false
    t.date "birthday", null: false
    t.string "address_prefecture", null: false
    t.string "address_city", null: false
    t.text "introduction"
    t.string "sound"
    t.string "profile_image_id"
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.boolean "online", default: false
    t.datetime "online_at"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "room_id", null: false
    t.text "body", null: false
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.datetime "read_at"
    t.index ["member_id"], name: "index_messages_on_member_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "notices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.text "body", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tweet_id"
    t.bigint "tweet_comment_id"
    t.bigint "article_id"
    t.index ["article_id"], name: "index_notices_on_article_id"
    t.index ["member_id"], name: "index_notices_on_member_id"
    t.index ["tweet_comment_id"], name: "index_notices_on_tweet_comment_id"
    t.index ["tweet_id"], name: "index_notices_on_tweet_id"
  end

  create_table "part_articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "part_id", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_part_articles_on_article_id"
    t.index ["part_id"], name: "index_part_articles_on_part_id"
  end

  create_table "part_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "part_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_part_members_on_member_id"
    t.index ["part_id"], name: "index_part_members_on_part_id"
  end

  create_table "parts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefectures", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweet_comment_favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "tweet_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_tweet_comment_favorites_on_member_id"
    t.index ["tweet_comment_id"], name: "index_tweet_comment_favorites_on_tweet_comment_id"
  end

  create_table "tweet_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "tweet_id", null: false
    t.text "body", null: false
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_id"
    t.index ["member_id"], name: "index_tweet_comments_on_member_id"
    t.index ["tweet_id"], name: "index_tweet_comments_on_tweet_id"
  end

  create_table "tweet_favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_tweet_favorites_on_member_id"
    t.index ["tweet_id"], name: "index_tweet_favorites_on_tweet_id"
  end

  create_table "tweets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.text "body", null: false
    t.string "image_id"
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_tweets_on_member_id"
  end

end
