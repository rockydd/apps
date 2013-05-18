require 'faker'

FactoryGirl.define do
  factory :payment do |f|
    f.amount { rand * 100}
    f.should_pay {rand * 100}
    f.user 
  end
end
