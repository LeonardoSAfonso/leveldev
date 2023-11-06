require "rails_helper"

describe ::ApplicationJob do
  it { expect(described_class.superclass).to eq(ActiveJob::Base) }
end
