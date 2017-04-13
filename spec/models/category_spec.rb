require 'rails_helper'

RSpec.describe Category do
  context 'validations' do
    it do
      is_expected.to validate_presence_of :name
      is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity
    end
  end

  context 'attributes' do
    it 'responds to name' do
      category = Category.new

      expect(category).to respond_to(:name)
      expect(category).to respond_to(:creatures)
    end
  end
  context 'relationships' do
    it 'has many creatures' do
      category = Category.create(name: 'cute')
      creatures = create_list(:creature, 2)
      category.creatures << creatures

      expect(category.creatures).to eq(creatures)
    end
  end
end
