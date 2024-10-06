# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  describe 'associations' do
    it 'contains expected associations' do
      expect(subject).to belong_to(:todo_list)
    end
  end

  describe 'validations' do
    it 'checks presence', factory: :stub do
      expect(subject).to validate_presence_of(:name)
    end
  end

  describe 'enums' do
    it 'defines status' do
      expect(subject).to define_enum_for(:status).with_values(%i[created
                                                                 completed]).with_default(:created)
    end
  end
end
