# frozen_string_literal: true

class CompleteTodoListService
  def initialize(todo_list)
    @todo_list = todo_list
    
  end

  def complete!
    todo_list.todo_items.each(&:completed!)
    if todo_list.todo_items.all(&:completed?)
      Rails.logger.info("Completed SUCCESSFULLY all Todo Items of Todo List id: #{todo_list.id}")
    else
      Rails.logger.info("FAILED to complete all Todo Items of Todo List id: #{todo_list.id}")
    end
  end

  def call
    complete!
  end

  private

  attr_reader :todo_list
end
