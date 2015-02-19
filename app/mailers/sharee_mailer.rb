class ShareeMailer < ApplicationMailer
  def claim_email(claimer, commission)
    @claimer = claimer
    @commission = commission
    mail(to: recipient, subject: "Claim from #{claimer.email}!")
  end

  private
  def recipient
    'info@sharee.io'
  end
end
