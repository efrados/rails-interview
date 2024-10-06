# frozen_string_literal: true

json.extract! todo_item, :id, :name, :status, :todo_list_id, :created_at, :updated_at
json.url todo_item_url(todo_item, format: :json)
