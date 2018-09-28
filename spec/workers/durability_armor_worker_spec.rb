require 'rails_helper'
RSpec.describe DurabilityArmorWorker, type: :worker do
  it 'jobs were pushed on to the queue' do
    expect {
      DurabilityArmorWorker.perform_async(1, 2)
    }.to change(DurabilityArmorWorker.jobs, :size).by(1)
  end
end
