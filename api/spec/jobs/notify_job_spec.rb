require "rails_helper"

describe ::NotifyJob do
  it { expect(described_class.superclass).to eq(ApplicationJob) }

  let(:instance) { described_class.new }
  let(:post) { Post.create(title: 'teste 123', body: 'teste teste teste', email: 'test@gmail.com') }
  let(:args) { { post_id: post.id } }
  let(:result) { instance.perform(args) }

  context 'when is a post' do
    let(:params) { { post: post } }
    let(:parameterized_mailer) { ActionMailer::Parameterized::Mailer.new(::PostMailer, params) }
    let(:message_delivery) { ActionMailer::Parameterized::MessageDelivery.new(::PostMailer, :notify_email, params) }

    it 'should be sending email with post' do
      expect(message_delivery).to receive(:deliver_now).and_call_original
      expect(parameterized_mailer).to receive(:notify_email).and_return(message_delivery)
      expect(::PostMailer).to receive(:with).with(post: post).and_return(parameterized_mailer)

      result
    end
  end

  context 'when is a comment' do
    let(:comment) { Comment.create(post_id: post.id, body: 'teste teste teste', email: 'test@gmail.com') }
    let(:args) { { comment_id: comment.id } }
    let(:params) { { comment: comment } }
    let(:parameterized_mailer) { ActionMailer::Parameterized::Mailer.new(::CommentMailer, params) }
    let(:message_delivery) { ActionMailer::Parameterized::MessageDelivery.new(::CommentMailer, :notify_email, params) }

    it 'should be sending email with comment' do
      expect(message_delivery).to receive(:deliver_now).and_call_original
      expect(parameterized_mailer).to receive(:notify_email).and_return(message_delivery)
      expect(::CommentMailer).to receive(:with).with(comment: comment).and_return(parameterized_mailer)

      result
    end
  end

  context 'when does not found anything' do
    let(:args) { {} }

    it 'does not send email' do
      expect(::CommentMailer).not_to receive(:with)
      expect(::PostMailer).not_to receive(:with)

      expect { result }.not_to raise_error
    end
  end
end
