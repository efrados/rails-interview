require 'rails_helper'

RSpec.describe "API::TodoList", type: :request do
  
  subject { get api_todo_lists_path }

  describe "GET /index" do
    let!(:todo_list_1) { create(:todo_list) }
    let!(:todo_list_2) { create(:todo_list) }
    let(:response_array) do
      [
        { id:todo_list_1.id, name: todo_list_1.name },
        { id:todo_list_2.id, name: todo_list_2.name }
      ]
      .map(&:stringify_keys)
    end

    it "renders a successful response" do
      subject

      expect(response).to be_successful
    end

    it 'includes todo list records' do
      subject

      expect(JSON.parse(response.body)).to match(response_array)
    end
  end
end
