class ChangeBodyToNotNullInReports < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reports, :body, false
  end
end
