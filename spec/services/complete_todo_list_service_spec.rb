# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompleteTodoListService do
  subject { described_class.call(todo_list) }

  let(:todo_list) { create(:todo_list) }

  context 'when the todo list has no todo items' do
    it 'logs the error' do
      expect(Rails.logger).to receive(:error).with(
        "There are no Todo Items in Todo List id: #{todo_list.id}"
      )
      subject
    end
  end

  context 'when the todolist has all the todo items completed' do
    let!(:todo_items) { create_list(:todo_item, 2, :completed, todo_list: todo_list) }

    it 'logs the error' do
      expect(Rails.logger).to receive(:error).with(
        "There are no Todo Items to complete in Todo List id: #{todo_list.id}"
      )
      subject
    end

    it 'does not try to update the already completed todo items' do
      expect_any_instance_of(TodoItem).not_to receive(:completed!)

      subject
    end
  end

  context 'when the todolist does not have all todo items completed' do
    let!(:todo_items) { create_list(:todo_item, 2, todo_list: todo_list) }
    let!(:completed_todo_item) { create(:todo_item, :completed, todo_list: todo_list) }

    it 'updates the pending todo_items' do
      expect { subject }
        .to change { todo_list.reload.todo_items.all?(&:completed?) }.from(false).to(true)
    end

    it 'does not try to update the already completed todo items' do
      expect(completed_todo_item).not_to receive(:completed!)

      subject
    end
  end
end
