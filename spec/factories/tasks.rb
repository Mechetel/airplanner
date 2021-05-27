FactoryBot.define do
  factory :task do
    done { false }
    name { Faker::Lorem.sentence }
    project
  end

  factory :invalid_task, class: 'Task' do
    done { false }
    name { '' }
    project
  end

  factory :task_done, class: 'Task' do
    done { true }
    name { Faker::Lorem.sentence }
    project
  end
end
