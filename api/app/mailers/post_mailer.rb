class PostMailer < ::ApplicationMailer
  def notify_email
    @post = params[:post]
    @url = "http://localhost:8080/posts/#{@post.id}"
    mail(to: @post.email, subject: 'New post in your account')
  end
end
