# frozen_string_literal: true

class CompleteTodoListJob < ApplicationJob
  queue_as :default

  def perform(todo_list_id)
    Rails.logger.info("Starting to Complete TodoList Job for #{todo_list_id}.")

    todo_list = TodoList.find(todo_list_id)
    CompleteTodoListService.call(todo_list)

    Rails.logger.info("Completed all list for TodoList Job for #{todo_list_id}.")
  end
end
