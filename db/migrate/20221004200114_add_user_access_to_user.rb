class AddUserAccessToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_access, :integer, default: 5
  end
end
