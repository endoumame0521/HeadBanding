class AddOnlineToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :online, :boolean, default: :false
  end
end
