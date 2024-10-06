require 'rails_helper'

RSpec.describe "todo_items/new", type: :view do
  let!(:todo_list) { create(:todo_list) }
  let(:todo_item) { build(:todo_item, todo_list: todo_list, name: 'Name') }

  before { assign(:todo_item, todo_item) }

  it "renders new todo_item form" do
    render

    assert_select "form[action=?][method=?]", todo_items_path, "post" do

      assert_select "input[name=?]", "todo_item[name]"

      assert_select "input[name=?]", "todo_item[status]"

      assert_select "input[name=?]", "todo_item[todo_list_id]"
    end
  end
end
