# frozen_string_literal: true

class CompleteTodoListService
  def self.call(todo_list)
    new(todo_list).complete!
  end

  def initialize(todo_list)
    @todo_list = todo_list
  end

  def complete!
    if todo_list.todo_items.count.zero?
      log_error("There are no Todo Items in Todo List id: #{todo_list.id}")
    elsif todo_list.todo_items.all?(&:completed?)
      log_error("There are no Todo Items to complete in Todo List id: #{todo_list.id}")
    else
      complete_todo_items
    end
  end

  private

  attr_reader :todo_list

  def log_error(message)
    Rails.logger.error(message)
  end

  def complete_todo_items
    todo_list.todo_items.each { |todo_item| todo_item.completed! unless todo_item.completed! }
  end
end
