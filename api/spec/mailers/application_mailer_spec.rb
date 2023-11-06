require "rails_helper"

describe ::ApplicationMailer do
  it { expect(described_class.superclass).to eq(::ActionMailer::Base) }
end
