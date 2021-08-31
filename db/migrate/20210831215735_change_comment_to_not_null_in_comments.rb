class ChangeCommentToNotNullInComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :comment, false
  end
end
