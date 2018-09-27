require 'rails_helper'

RSpec.describe Zombie, type: :model do
  describe 'attributes validations' do
    it 'name attribute must be present' do
      should validate_presence_of :name
    end

    it 'speed attribute must be present' do
      should validate_presence_of :speed
    end

    it 'turn_date attribute must be present' do
      should validate_presence_of :turn_date
    end
  end

  describe 'relations validations' do
    it 'should have many zombie_armors with destroy dependency' do
      should have_many(:zombie_armors).dependent(:destroy)
    end

    it 'should have many zombie_weapons with destroy dependency' do
      should have_many(:zombie_weapons).dependent(:destroy)
    end

    it 'should have many armors through zombie_armors' do
      should have_many(:armors).through(:zombie_armors)
    end

    it 'should have many weapons through zombie_weapons' do
      should have_many(:weapons).through(:zombie_weapons)
    end
  end
end
