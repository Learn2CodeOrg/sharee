# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def claim_email
    user = User.first
    commission = rand(100..500)
    UserMailer.claim_email(user, commission)
  end
end
