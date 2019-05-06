class AddEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email, :string, limit: 100
    add_index :users, :email, unique: true
  end
end