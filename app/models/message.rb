class Message < ApplicationRecord
  belongs_to :member
  belongs_to :room

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}

  #Messageをcreateした直後にJobを実行。RoomChannelに対してcreateしたMessageをBroadCastする。
  after_create_commit { MessageBroadcastJob.perform_later self }
end
