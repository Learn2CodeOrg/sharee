class WelcomeController < ApplicationController

  def index
    @sharee_button_html = CGI.escape_html render_to_string 'shared/_sharee_button', layout: false, locals: { campaign: '[campaign]' }
    @sharee_thank_html  = CGI.escape_html render_to_string 'shared/_sharee_thank',  layout: false, locals: { code: '[code]', email: '[email]', price: '[price]'}
    @sharee_script_html = CGI.escape_html render_to_string 'shared/_sharee_script', layout: false, locals: { host: 'http://' + request.host_with_port }


    @samples = {
        last_campaign_id: Campaign.any? ? Campaign.last.id : 1,
        code: [*('a'..'z')].sample(12).join,
        email: [*('a'..'z')].sample(8).join + '@kupca.sk',
        price: rand(80..250)
    }
  end
end
