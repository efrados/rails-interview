# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CompleteTodoListJob, type: :job do
  subject(:job) { described_class.perform_now(todo_list_id) }

  context 'when the todo_list_id does not belong to a todo_list' do
    let(:todo_list_id) { 1 }

    it 'raises a not found error' do
      expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when the todo_list_id exists' do
    let(:todo_list) { create(:todo_list) }
    let(:todo_list_id) { todo_list.id }

    it 'calls the CompleteTodoListService' do
      expect(CompleteTodoListService).to receive(:call).with(todo_list).and_call_original

      subject
    end
  end
end
