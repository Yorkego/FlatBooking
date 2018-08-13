class SendAdminMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    rake "email_sender"
  end
end
