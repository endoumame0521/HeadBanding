class AddOnlineAtToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :online_at, :datetime
  end
end
