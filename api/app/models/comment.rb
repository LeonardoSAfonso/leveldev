class Comment < ApplicationRecord
  after_create :schedule_job_notify
  belongs_to :post

  validates :post_id, :body, :email, presence: true

  private

  def schedule_job_notify
    NotifyJob.set(wait: 10.seconds).perform_later(comment_id: self.id)
  end
end
