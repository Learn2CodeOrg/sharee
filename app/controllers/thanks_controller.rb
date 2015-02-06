class ThanksController < ApplicationController
  before_filter :restrict_to_development

  def index
    @random_code = rand(36**10).to_s(36)
    @random_email = 'katka@nalade.sk'
    @random_price = rand(50..250)
  end

  protected

  def restrict_to_development
    head(:bad_request) unless Rails.env.development?
  end
end
