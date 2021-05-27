FactoryBot.define do
  factory :comment do
    task
    text { Faker::Lorem.paragraph }
  end

  factory :invalid_comment, class: 'Comment' do
    task
    text { '' }
  end
end
