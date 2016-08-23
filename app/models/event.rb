class Event < ActiveRecord::Base
  include IceCube
  
  attr_accessor :recurring_rule
  serialize :recurring_rule, Hash

	belongs_to :user

	validates :title,
						:date,
						presence: true

	def recurring_rule=(new_rule)
    if RecurringSelect.is_valid_rule?(new_rule)
      write_attribute(:recurring_rule, RecurringSelect.dirty_hash_to_rule(new_rule).to_hash)
    else
      write_attribute(:recurring_rule, nil)
    end
  end					
end
