class Event < ActiveRecord::Base
  include IceCube
  
  attr_accessor :recurring_rule, :color

  serialize :schedule, IceCube::Schedule

	belongs_to :user

	validates :title,
						:date,
						presence: true			
end
