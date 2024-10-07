# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TodoItem', type: :request do
  let(:valid_attributes) { { name: 'valid', todo_list_id: todo_list.id } }

  let(:invalid_attributes) { { invalid_attribute: 'invalid' } }

  let(:todo_list) { create(:todo_list) }

  describe 'GET /todo_items' do
    let!(:todo_items) { create_list(:todo_item, 2) }

    it 'renders a successful response' do
      get todo_items_url

      expect(response).to be_successful
    end
  end

  describe 'GET /todo_items/id' do
    let!(:todo_item) { create(:todo_item) }

    it 'renders a successful response' do
      get todo_item_url(todo_item)

      expect(response).to be_successful
    end
  end

  describe 'GET /todo_items/new' do
    it 'renders a successful response' do
      get new_todo_item_url
      expect(response).to be_successful
    end
  end

  describe 'GET /todo_items/edit' do
    let!(:todo_item) { create(:todo_item) }

    it 'renders a successful response' do
      get edit_todo_item_url(todo_item)
      expect(response).to be_successful
    end
  end

  describe 'POST /todo_items' do
    context 'with valid parameters' do
      it 'creates a new TodoItem' do
        expect { post todo_items_url, params: { todo_item: valid_attributes } }
          .to change(TodoItem, :count).by(1)
      end

      it 'redirects to the created todo_item' do
        post todo_items_url, params: { todo_item: valid_attributes }

        expect(response).to redirect_to(todo_item_url(TodoItem.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new TodoItem' do
        expect do
          post todo_items_url, params: { todo_item: invalid_attributes }
        end.not_to change(TodoItem, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post todo_items_url, params: { todo_item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /todo_items/id' do
    subject do
      patch todo_item_url(todo_item), params: { todo_item: new_attributes }
      response
    end

    let(:initial_name) { 'inital name' }
    let!(:todo_item) { create(:todo_item, name: initial_name) }
    let(:new_name) { 'new name' }
    let(:new_attributes) { { name: new_name } }

    context 'with valid parameters' do
      it 'updates the requested todo_item' do
        expect { subject }.to change { todo_item.reload.name }.from(initial_name).to(new_name)
      end

      it 'redirects to the todo_item' do
        expect(subject).to redirect_to(todo_item_url(todo_item))
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { name: nil } }

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        expect(subject).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /todo_items/id/complete' do
    subject do
      put complete_todo_item_url(todo_item)
      response
    end

    let!(:todo_item) { create(:todo_item) }

    context 'when the todo item is ready to be completed' do
      it 'updates the requested todo_item' do
        expect { subject }.to change { todo_item.reload.status }.from('created').to('completed')
      end

      it 'redirects to the todo_item' do
        expect(subject).to redirect_to(todo_item_url(todo_item))
      end

      it 'shows the success message' do
        subject

        expect(request.flash[:notice]).to eq('Todo item was successfully completed.')
      end
    end

    context 'when the todo item is already completed' do
      let!(:todo_item) { create(:todo_item, :completed) }

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not updates the requested todo_item' do
        expect { subject }.not_to change { todo_item.reload.status }.from('completed')
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:todo_item) { create(:todo_item) }

    it 'destroys the requested todo_item' do
      expect { delete todo_item_url(todo_item) }.to change(TodoItem, :count).by(-1)
    end

    it 'redirects to the todo_items list' do
      delete todo_item_url(todo_item)

      expect(response).to redirect_to(todo_items_url)
    end
  end
end
