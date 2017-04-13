require 'rails_helper'

RSpec.describe Creature do
  context 'validations' do
    it do
      is_expected.to validate_presence_of :breed
      is_expected.to validate_presence_of :price
      is_expected.to validate_presence_of :description
      is_expected.to validate_presence_of :image_url
      is_expected.to validate_uniqueness_of(:breed).ignoring_case_sensitivity
    end
  end

  context 'attributes' do
    it 'responds to breed, price, description, image_url' do
      creature = Creature.new

      expect(creature).to respond_to(:breed)
      expect(creature).to respond_to(:price)
      expect(creature).to respond_to(:description)
      expect(creature).to respond_to(:image_url)
      expect(creature).to respond_to(:categories)
    end
  end
  context 'relationships' do
    it 'has many categories' do
      creature = Creature.create(breed: 'dingo-fox',
                                 price: '15.00',
                                 description: 'this wee fellow lives on Mars')
      categories = create_list(:category, 2)
      creature.categories << categories

      expect(creature.categories).to eq(categories)
    end
  end
end
