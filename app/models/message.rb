class Message < ApplicationRecord
  has_many :announces, dependent: :destroy
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

  # メッセージを更新(既読に)した直後、RoomChannelに対して既読をBroadCastする
  after_update_commit :read_self

  def read_self
    if saved_change_to_read?
      MessageReadBroadcastJob.perform_later(self)
    end
  end

  # メッセージの通知を作成
  def create_announce_message!(member_id, room_id)
    Entry.where(room_id: room_id).each do |entry|
      if member_id != entry.member_id
        @reciever_id = entry.member_id
      end
    end

    Announce.find_or_create_by(
      announcer_id: member_id,
      reciever_id: @reciever_id,
      message_id: id,
      action: "message"
    )
  end
end
