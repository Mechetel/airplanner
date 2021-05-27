FactoryBot.define do
  factory :project do
    name { Faker::Lorem.sentence }
    user
  end

  factory :invalid_project, class: 'Project' do
    name { "" }
    user
  end
end
