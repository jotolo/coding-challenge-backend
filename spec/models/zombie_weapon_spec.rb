require 'rails_helper'

RSpec.describe ZombieWeapon, type: :model do
  describe 'relations validations' do
    it 'should belongs to zombie' do
      should belong_to(:zombie)
    end

    it 'should belongs to weapon' do
      should belong_to(:weapon)
    end
  end
end
