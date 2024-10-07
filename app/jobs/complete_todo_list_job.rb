class CompleteTodoListJob < ApplicationJob
  queue_as :default

  def perform(todo_list_id)
    Rails.logger.info("Starting to Complete TodoList Job for #{todo_list_id}.")

    todo_list = TodoList.find(todo_list_id)
    return log_not_found(todo_list) if todo_list.blank?

    CompleteTodoListService.new(todo_list).complete!
  end

  def log_not_found(todo_list_id)
    Rails.logger.info("CompleteTodoListJob => TodoList not found #{todo_list_id}")
  end
end
