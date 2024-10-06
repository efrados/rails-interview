require 'rails_helper'

describe Api::TodoItemsController do
  render_views

  describe 'POST index' do
    subject { post :create, format: :json }
    let!(:todo_list) { TodoList.create(name: 'Setup RoR project') }

    context 'when format is JSON' do
      it 'returns a success code' do
        

        expect(response.status).to eq(200)
      end

      it 'includes todo list records' do
        get :index, format: :json

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
end
