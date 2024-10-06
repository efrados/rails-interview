# frozen_string_literal: true

FactoryBot.define do
  factory :todo_item do
    association :todo_list

    name { Faker::Lorem.word }
  end
end
