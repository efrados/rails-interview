require 'rails_helper'

RSpec.describe "todo_items/show", type: :view do
  before(:each) do
    assign(:todo_item, TodoItem.create!(
      name: "Name",
      status: 2,
      todo_lists: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
