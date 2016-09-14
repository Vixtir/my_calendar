FactoryGirl.define do
  factory :event do
    title "MyString"
    date Date.today
    recurring_rule "null"
    remind false
    user
  end
end
