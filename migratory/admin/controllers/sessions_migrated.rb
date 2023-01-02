
            #
 # This file was originally written for Padrino 0.13 by
 # Brandon Faloona, then migrated to Sinatra 3.0.5 by
 # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
 # December 2022.
 #

require 'sinatra/base'

class Monologues::Admin < Sinatra::Base
  enable :sessions

  get '/sessions/new' do
    # Renders the sessions/new view without a layout
    render '/sessions/new', nil, :layout => false
  end

  post '/sessions' do
    # Authenticates an account using the email and password provided
    account = Account.authenticate(params[:email], params[:password])

    # If the authentication is successful, sets the current account and redirects to the base index page
    if account
      set_current_account(account)
      redirect '/'
    # If the authentication fails, and the environment is set to development, bypasses authentication and sets the current account
    elsif Sinatra.environment == :development && params[:bypass]
      account = Account.first
      set_current_account(account)
      redirect '/'
    # If the authentication fails, flashes an error and renders the session/new view without a layout
    else
      params[:email] = h(params[:email])
      flash.now[:error] = pat('login.error')
      render '/sessions/new', nil, :layout => false
    end
  end

  delete '/sessions' do
    # Sets the current account to nil and redirects to the session new page
    set_current_account(nil)
    redirect '/sessions/new'
  end
end