class ShareeMailer < ApplicationMailer
  def claim_email(user, commission)
    @user = user
    @commission = commission
    mail(to: recipient, subject: default_i18n_subject(email: @user.email))
  end

  private
  def recipient
    'info@sharee.io'
  end
end
