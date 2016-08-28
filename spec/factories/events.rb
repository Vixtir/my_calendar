FactoryGirl.define do
  factory :event do
    title "MyString"
    date "2016-08-10"
    recurring_rule "null"
    user
  end
end
