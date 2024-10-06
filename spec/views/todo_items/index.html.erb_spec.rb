# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'todo_items/index', type: :view do
  let!(:todo_list) { create(:todo_list) }

  before { assign(:todo_items, create_list(:todo_item, 2, todo_list: todo_list, name: 'Name')) }

  it 'renders a list of todo_items' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'), count: 2
    assert_select cell_selector, text: Regexp.new('created'), count: 2
    assert_select cell_selector, text: Regexp.new(todo_list.name), count: 2
  end
end
