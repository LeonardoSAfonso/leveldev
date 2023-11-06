require "rails_helper"

RSpec.describe Comment do
  describe "validations" do
    it { should validate_presence_of :post_id }
    it { should validate_presence_of :body }
    it { should validate_presence_of :email }
  end

  describe '#notify_email' do
    let(:post) { Post.create(title: 'teste 123', body: 'teste teste teste', email: 'test@gmail.com') }
    let(:comment) { Comment.new(post_id: post.id, body: 'teste teste teste', email: 'test@gmail.com') }
    let(:result) { comment.save! }
    let(:job) { NotifyJob }
    let(:seted_job) { job.set(wait: 10.seconds) }

    it 'should be schedule a job' do
      expect(job).to receive(:set).with(wait: 10.seconds).twice.and_return(seted_job)
      expect(seted_job).to receive(:perform_later).twice.and_call_original

      expect(result).to be_truthy
    end
  end
end
