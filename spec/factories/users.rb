require 'faker'

FactoryBot.define do
  password = Faker::Internet.password

  factory :user , class: 'User'do
    email                 { Faker::Internet.email }
    username              { Faker::Lorem.word }
    first_name            { Faker::Lorem.word }
    last_name             { Faker::Lorem.word }
    password              { password }
    password_confirmation { password }
  end
end
