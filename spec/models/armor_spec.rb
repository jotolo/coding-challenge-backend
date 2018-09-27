require 'rails_helper'

RSpec.describe Armor, type: :model do
  describe 'attributes validations' do
    it 'name attribute must be present' do
      should validate_presence_of :name
    end

    it 'defense_points attribute must be present' do
      should validate_presence_of :defense_points
    end

    it 'durability attribute must be present' do
      should validate_presence_of :durability
    end

    it 'price attribute must be present' do
      should validate_presence_of :price
    end
  end

  describe 'relations validations' do
    it 'should have many zombie_armors with destroy dependency' do
      should have_many(:zombie_armors).dependent(:destroy)
    end

    it 'should have many zombies through zombie_armors' do
      should have_many(:zombies).through(:zombie_armors)
    end
  end
end
