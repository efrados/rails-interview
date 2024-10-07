# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'todo_items/show', type: :view do
  subject do
    render
    rendered
  end

  let!(:todo_list) { create(:todo_list) }
  let(:todo_item) { create(:todo_item, todo_list: todo_list, name: 'Name') }

  before { assign(:todo_item, todo_item) }

  it 'renders attributes in <p>' do
    expect(subject).to match(/Name/)
    expect(subject).to match(/1/)
    expect(subject).to match(//)
  end

  context 'when the todo item is completed' do
    let(:todo_item) { create(:todo_item, :completed, todo_list: todo_list) }

    it 'does not show the complete button' do
      expect(subject).to have_tag('form', with: { action: complete_todo_item_path(todo_item) })
    end
  end

  context 'when the todo item is not completed' do
    it 'shows the complete button' do
      expect(subject).to have_tag('form', with: { action: complete_todo_item_path(todo_item) }) do
        have_tag('button', with: { class: 'btn', type: 'submit', text: 'Complete this item' })
      end
    end
  end
end
