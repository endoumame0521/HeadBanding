class Message < ApplicationRecord
  belongs_to :member
  belongs_to :room

  # バリデーションSTART------------------------------------------------------------------------------------------
  validates :body, presence: true, length: { maximum: 300 }
  # バリデーションEND--------------------------------------------------------------------------------------------

  # Gem kamirariの表示ページ数
  paginates_per 20

  # 最新順に並び替え
  default_scope -> { order(created_at: :desc)}

  #Messageをcreateした直後にJobを実行。RoomChannelに対してcreateしたMessageをBroadCastする。
  after_create_commit { MessageBroadcastJob.perform_later self }

  #Messageをdestroyする直前にJobを実行。RoomChannelに対してdestroyするMessageをBroadCastして非表示にする。
  before_destroy { MessageRemoveBroadcastJob.perform_later self }

  after_update_commit :read_self

  def read_self
    if saved_change_to_read?
      MessageReadBroadcastJob.perform_later(self)
    end
  end
end
