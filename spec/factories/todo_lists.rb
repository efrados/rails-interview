# frozen_string_literal: true

FactoryBot.define do
  factory :todo_list do
    name { Faker::Lorem.word }
  end
end
