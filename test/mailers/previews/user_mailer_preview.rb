# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def signup_email_preview
  	UserMailer.signup_email(User.first)
  end
end
