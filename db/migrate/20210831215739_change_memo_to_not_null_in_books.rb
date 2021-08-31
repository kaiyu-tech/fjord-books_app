class ChangeMemoToNotNullInBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :books, :memo, false
  end
end
