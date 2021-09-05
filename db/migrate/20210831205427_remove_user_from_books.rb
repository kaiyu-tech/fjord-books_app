class RemoveUserFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :books, :string
    remove_reference :books, :user, null: false, foreign_key: true
  end
end
