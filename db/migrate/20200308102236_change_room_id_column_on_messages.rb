class ChangeRoomIdColumnOnMessages < ActiveRecord::Migration[5.2]
  def change
    change_column_null :messages, :room_id, false
  end
end
