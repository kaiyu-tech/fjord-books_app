class RemoveUserFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_reference :reports, :user, null: false, foreign_key: true
  end
end
