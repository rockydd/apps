require 'faker'

FactoryGirl.define do
  factory :activity do |f|
    f.subject { Faker::Name.first_name }
    f.cost { rand * 1000}
    f.atype{ (rand * 10)%2}
    f.status { "New" }
    f.occur_at { Time.now}
    factory :activity_with_payments do
      after(:build) do |activity|
        payments=FactoryGirl.create_list(:payment, 5, amount: activity.cost/5.0, should_pay: activity.cost/5.0, activity:activity)
        activity.payments = payments
      end
    end
    
  end
end
