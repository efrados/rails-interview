require 'rails_helper'

RSpec.describe "API::TodoItems", type: :request do
  let(:todo_list) { create(:todo_list) }

  let(:expected_response) do
    { id: todo_item.id, name: todo_item.name, status: todo_item.status, todo_list_id: todo_list.id }
  end

  describe "POST /todolists/todo_list_id/todo_items/" do
    let(:valid_attributes) { { name: 'valid' } }
    let(:invalid_attributes) { { invalid_attribute: 'invalid' } }

    subject do
      post api_todo_list_todo_items_path(todo_list), params: attributes
      response
    end

    context "with valid parameters" do
      let(:attributes) { valid_attributes }
      let(:todo_item) { TodoItem.last }
      let(:expected_response) { {id: todo_item.id, name: todo_item.name} }

      it "renders a successful response" do
        expect(subject).to be_successful
      end

      it "creates a new TodoItem" do
        expect { subject }.to change(TodoItem, :count).by(1)
      end

      it "returns the created todo_item" do
        expect(JSON.parse(subject.body, symbolize_names: true)).to eq(expected_response)
      end
    end

    context "with invalid parameters" do
      let(:attributes) { invalid_attributes }

      it "does not create a new TodoItem" do
        expect { subject }.to change(TodoItem, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        expect(subject).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /todolists/todo_list_id/todo_items/id/complete" do
    let(:initial_name) { 'inital name' }
    let!(:todo_item) { create(:todo_item, name: initial_name, todo_list: todo_list) }

    subject do
      put complete_api_todo_list_todo_item_path(todo_list, id: todo_item.id)
      todo_item.reload
      response
    end

    context "when the todo item is ready to be completed" do
      it "completes requested todo_item" do
        expect { subject }.to change {todo_item.reload.status }.from('created').to('completed')
      end

      it "returns the created todo_item" do
        expect(JSON.parse(subject.body, symbolize_names: true)).to include(expected_response)
      end
    end

    context "when the todo item is already completed" do
      let!(:todo_item) { create(:todo_item, :completed, name: initial_name, todo_list: todo_list) }
    
      it "returns the created todo_item" do
        expect(JSON.parse(subject.body, symbolize_names: true)).to include(expected_response)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:todo_item) { create(:todo_item, todo_list: todo_list) }

    subject do
      delete api_todo_list_todo_item_path(todo_list, id: todo_item.id)
      response
    end
    
    it "destroys the requested todo_item" do
      expect { subject }.to change(TodoItem, :count).by(-1)
    end

    it "returns the created todo_item" do
      expect(JSON.parse(subject.body, symbolize_names: true)).to include(expected_response)
    end
  end
end
