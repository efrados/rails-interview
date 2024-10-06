# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoList, type: :model do
  describe 'associations' do
    it 'contains expected associations' do
      expect(subject).to have_many(:todo_items).dependent(:destroy)
    end
  end
end
