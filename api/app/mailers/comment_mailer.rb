class CommentMailer < ::ApplicationMailer
  def notify_email
    @comment = params[:comment]
    @url = "http://localhost:8080/comments/#{@comment.id}"
    mail(to: @comment.post.email, subject: 'New comment in your post')
  end
end
