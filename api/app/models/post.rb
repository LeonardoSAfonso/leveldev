class Post < ApplicationRecord
  after_create :schedule_job_notify
	validates :title, presence: true, length: { minimum: 3 }

  private

  def schedule_job_notify
    NotifyJob.set(wait: 10.seconds).perform_later(post_id: self.id)
  end
end
