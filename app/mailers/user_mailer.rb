class UserMailer < ApplicationMailer
  def claim_email(user, commission)
    @user = user
    @commission = commission
    mail(to: user.email, subject: default_i18n_subject())
  end
end
