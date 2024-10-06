class TodoItem < ApplicationRecord
  belongs_to :todo_list
  enum :status, { created: 0, completed: 1 }, default: :created
end
