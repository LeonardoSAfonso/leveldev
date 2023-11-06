require "rails_helper"

RSpec.describe Topic do
  describe "validations" do
    it { should validate_presence_of :titulo }
  end
end
