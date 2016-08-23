class AddRecurringRuleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recurring_rule, :string
  end
end
