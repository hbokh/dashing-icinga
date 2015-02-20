require 'dashing'

configure do
  #set :auth_token, 'YOUR_AUTH_TOKEN'

  # Icinga access (from Docker env)
  set :icinga_cgi,  ENV['ICINGA_CGI']
  set :icinga_user, ENV['ICINGA_USER']
  set :icinga_pass, ENV['ICINGA_PASS']

  # Twitter tokens (from Docker env)
  set :twitter_key,          ENV['TWITTER_KEY']
  set :twitter_secret,       ENV['TWITTER_SECRET']
  set :twitter_token,        ENV['TWITTER_TOKEN']
  set :twitter_token_secret, ENV['TWITTER_TOKEN_SECRET']

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
