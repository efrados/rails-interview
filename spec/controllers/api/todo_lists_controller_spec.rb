require 'rails_helper'

describe API::TodoListsController do
  render_views

  describe 'GET index' do
    let!(:todo_list) { TodoList.create(name: 'Setup RoR project') }
    let(:format) { [:json, :html].sample }

    subject { get :index, format: format }

    it 'returns a success code' do
      subject

      expect(response.status).to eq(200)
    end

    it 'includes todo list records' do
      subject

      todo_lists = JSON.parse(response.body)

      aggregate_failures 'includes the id and name' do
        expect(todo_lists.count).to eq(1)
        expect(todo_lists[0].keys).to match_array(['id', 'name'])
        expect(todo_lists[0]['id']).to eq(todo_list.id)
        expect(todo_lists[0]['name']).to eq(todo_list.name)
      end
    end
  end
end
