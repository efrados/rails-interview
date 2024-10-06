require 'rails_helper'

RSpec.describe "todo_items/new", type: :view do
  before(:each) do
    assign(:todo_item, TodoItem.new(
      name: "MyString",
      status: 1,
      todo_list: todo_list
    ))
  end
  let!(:todo_list) {
    TodoList.create!(
      name: "list",
    )
  }

  it "renders new todo_item form" do
    render

    assert_select "form[action=?][method=?]", todo_items_path, "post" do

      assert_select "input[name=?]", "todo_item[name]"

      assert_select "input[name=?]", "todo_item[status]"

      assert_select "input[name=?]", "todo_item[todo_list_id]"
    end
  end
end
