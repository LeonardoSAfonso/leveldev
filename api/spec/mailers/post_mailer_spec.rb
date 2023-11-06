require "rails_helper"

describe PostMailer, type: :mailer do
  describe '#notify_email' do
    let(:post) { Post.create(title: 'teste 123', body: 'teste teste teste', email: 'test@gmail.com') }
    let(:mail) { described_class.with(post: post).notify_email.deliver_now }

    it 'validates email attributes' do
      expect(mail.subject).to eq('New post in your account')
      expect(mail.to).to eq([post.email])
      expect(mail.from).to eq(['no-respond@gmail.com'])

      expect(mail.body.raw_source).to match('You published a new post, congrats!')
    end
  end
end
