require 'rails_helper'

RSpec.describe "todo_items/index", type: :view do
  let(:todo_list) {
    TodoList.create!(
      name: list_name,
    )
  }
  let(:list_name) {'list'}
  before(:each) do
    assign(:todo_items, [
      TodoItem.create!(
        name: "Name",
        status: 1,
        todo_list: todo_list
      ),
      TodoItem.create!(
        name: "Name",
        status: 1,
        todo_list: todo_list
      )
    ])
  end

  it "renders a list of todo_items" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(1.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(list_name), count: 2
  end
end
