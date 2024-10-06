require 'rails_helper'

RSpec.describe "todo_items/show", type: :view do
  before(:each) do
    assign(:todo_item, TodoItem.create!(
      name: "Name",
      status: 1,
      todo_list: todo_list
    ))
  end

  let(:todo_list) {
    TodoList.create!(
      name: "list",
    )
  }

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
