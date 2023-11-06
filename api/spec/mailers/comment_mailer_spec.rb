require "rails_helper"

describe CommentMailer, type: :mailer do
  describe '#notify_email' do
    let(:post) { Post.create(title: 'teste 123', body: 'teste teste teste', email: 'test@gmail.com') }
    let(:comment) { Comment.create(post_id: post.id, body: 'teste teste teste', email: 'test@gmail.com') }
    let(:mail) { described_class.with(comment: comment).notify_email.deliver_now }

    it 'validates email attributes' do
      expect(mail.subject).to eq('New comment in your post')
      expect(mail.to).to eq([post.email])
      expect(mail.from).to eq(['no-respond@gmail.com'])

      expect(mail.body.raw_source).to match('You have a new comment in your post')
    end
  end
end
