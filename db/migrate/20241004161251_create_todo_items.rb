# frozen_string_literal: true

class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
