# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'todo_items/show', type: :view do
  let!(:todo_list) { create(:todo_list) }
  let(:todo_item) { create(:todo_item, todo_list: todo_list, name: 'Name') }

  before { assign(:todo_item, todo_item) }

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
