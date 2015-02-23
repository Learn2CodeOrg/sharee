class DeviseMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  default from: 'no-reply@sharee.io'
  default reply_to: 'no-reply@sharee.io'
  layout 'mailer'
end
