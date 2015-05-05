source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bourbon' # sass mixins
gem 'neat' # grid system
gem 'refills' # frontend components

gem 'high_voltage', '~> 2.2.1' # static site routing
gem 'foreman'
gem 'rack-cors', :require => 'rack/cors'

gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'

gem 'sinatra', :require => nil
gem 'sidekiq'

gem 'devise'
gem 'devise_invitable', '~> 1.3.4'
gem 'devise-async'
gem 'rest-client'
gem 'rollbar'

group :production do
  gem 'rails_12factor'
  gem 'thin'
end

group :development do
  #gem 'better_errors'
  #gem 'binding_of_caller'
  gem 'hirb'
  #gem 'letter_opener'
  gem 'quiet_assets'
  gem 'populator'
  gem 'faker'
  gem 'meta_request'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'letter_opener'
end

