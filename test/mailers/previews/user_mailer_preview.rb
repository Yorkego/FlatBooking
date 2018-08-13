# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/signup_cofirmation
  def signup_cofirmation
    UserMailer.signup_cofirmation
  end

end
