require 'rails_helper'

RSpec.describe Weapon, type: :model do
  describe 'attributes validations' do
    it 'name attribute must be present' do
      should validate_presence_of :name
    end

    it 'attack_points attribute must be present' do
      should validate_presence_of :attack_points
    end

    it 'durability attribute must be present' do
      should validate_presence_of :durability
    end

    it 'price attribute must be present' do
      should validate_presence_of :price
    end

    it 'attack_points attribute must be greater than 0' do
      should validate_numericality_of(:attack_points).is_greater_than(0)
    end

    it 'durability attribute must be greater than 0' do
      should validate_numericality_of(:durability).is_greater_than(0)
    end

    it 'price attribute must be greater than 0' do
      should validate_numericality_of(:price).is_greater_than(0)
    end
  end

  describe 'relations validations' do
    it 'should have many zombie_weapons with destroy dependency' do
      should have_many(:zombie_weapons).dependent(:destroy)
    end

    it 'should have many zombies through zombie_weapons' do
      should have_many(:zombies).through(:zombie_weapons)
    end
  end
end
