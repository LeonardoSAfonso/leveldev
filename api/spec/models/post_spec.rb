require "rails_helper"

RSpec.describe Post do
  describe "validations" do
    #it "should be valid when title is filled" do
    #  subject.title = "This is a nice post"
    #  expect(subject).to be_valid
    #end

    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_least(3) }
  end

  describe '#notify_email' do
    let(:post) { Post.new(title: 'teste 123', body: 'teste teste teste', email: 'test@gmail.com') }
    let(:result) { post.save! }
    let(:job) { NotifyJob }
    let(:seted_job) { job.set(wait: 10.seconds) }

    it 'should be schedule a job' do
      expect(job).to receive(:set).with(wait: 10.seconds).and_return(seted_job)
      expect(seted_job).to receive(:perform_later).and_call_original

      expect(result).to be_truthy
    end
  end
end
