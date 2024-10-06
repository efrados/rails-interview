# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::TodoList', type: :request do
  subject do
    get api_todo_lists_path
    response
  end

  describe 'GET /index' do
    let!(:first_todo_list) { create(:todo_list) }
    let!(:second_todo_list) { create(:todo_list) }
    let(:response_array) do
      [
        { id: first_todo_list.id, name: first_todo_list.name },
        { id: second_todo_list.id, name: second_todo_list.name }
      ]
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'includes todo list records' do
      expect(JSON.parse(subject.body, symbolize_names: true)).to match(response_array)
    end
  end
end
