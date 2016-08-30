class AddRecurringRuleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recurring_rule, :text
  end
end
