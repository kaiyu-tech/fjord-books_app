class ChangeTitleToNotNullInBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :books, :title, false
  end
end
