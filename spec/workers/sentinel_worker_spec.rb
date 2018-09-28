require 'rails_helper'
RSpec.describe SentinelWorker, type: :worker do
  it 'jobs were pushed on to the queue' do
    expect {
      SentinelWorker.perform_async(1, 2)
    }.to change(SentinelWorker.jobs, :size).by(1)
  end
end
