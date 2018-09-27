require 'rails_helper'
RSpec.describe DurabilityWeaponWorker, type: :worker do
  it 'jobs were pushed on to the queue' do
    expect {
      DurabilityWeaponWorker.perform_async(1, 2)
    }.to change(DurabilityWeaponWorker.jobs, :size).by(1)
  end
end
