require 'rails_helper'

RSpec.describe "todo_items/edit", type: :view do
  let(:todo_list) {
    TodoList.create!(
      name: "list",
    )
  }
  let(:todo_item) {
    TodoItem.create!(
      name: "MyString",
      status: 1,
      todo_list: todo_list
    )
  }

  before(:each) do
    assign(:todo_item, todo_item)
  end

  it "renders the edit todo_item form" do
    render

    assert_select "form[action=?][method=?]", todo_item_path(todo_item), "post" do

      assert_select "input[name=?]", "todo_item[name]"

      assert_select "input[name=?]", "todo_item[status]"

      assert_select "input[name=?]", "todo_item[todo_list_id]"
    end
  end
end
