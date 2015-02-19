class UserMailer < ApplicationMailer
  def claim_email(user, commission)
    @user = user
    @commission = commission
    mail(to: user.email, subject: 'Claim request')
  end
end
