class AddRemindToEvents < ActiveRecord::Migration
  def change
    add_column :events, :remind, :boolean, default: false
  end
end
