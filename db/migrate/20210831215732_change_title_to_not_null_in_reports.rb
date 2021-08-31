class ChangeTitleToNotNullInReports < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reports, :title, false
  end
end
