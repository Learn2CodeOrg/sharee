class WelcomeController < ApplicationController

  def index
    @sharee_button_html = render_to_string 'shared/_sharee_button', layout: false
    @sharee_thank_html  = render_to_string 'shared/_sharee_thank',  layout: false
    @sharee_script_html = render_to_string 'shared/_sharee_script', layout: false
  end
end
