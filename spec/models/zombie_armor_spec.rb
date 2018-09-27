require 'rails_helper'

RSpec.describe ZombieArmor, type: :model do
  describe 'relations validations' do
    it 'should belongs to zombie' do
      should belong_to(:zombie)
    end

    it 'should belongs to armor' do
      should belong_to(:armor)
    end
  end
end
