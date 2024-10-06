# frozen_string_literal: true

json.array! @todo_items, partial: 'todo_items/todo_item', as: :todo_item
