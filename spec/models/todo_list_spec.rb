require 'rails_helper'

RSpec.describe TodoList, type: :model do
  describe 'associations' do
    it 'contains expected associations' do
      is_expected.to have_many(:todo_items)
    end
  end
end
