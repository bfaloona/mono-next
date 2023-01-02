
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

require 'sinatra'
require 'sinatra/contrib'

# Defines the Admin controller for accounts
class Admin < Sinatra::Base
  get '/accounts' do
    # Retrieve all accounts
    @title = "Accounts"
    @accounts = Account.all
    render 'accounts/index'
  end

  get '/accounts/new' do
    # Create a new account
    @title = "New Account"
    @account = Account.new
    render 'accounts/new'
  end

  post '/accounts' do
    # Create a new account
    @account = Account.new(params[:account])
    if @account.save
      @title = "Account #{@account.id}"
      flash[:success] = "Account successfully created"
      params[:save_and_continue] ? redirect('/accounts') : redirect("/accounts/#{@account.id}/edit")
    else
      @title = "New Account"
      flash.now[:error] = "Error creating account"
      render 'accounts/new'
    end
  end

  get '/accounts/:id/edit' do
    # Retrieve an account for editing
    @title = "Edit Account #{params[:id]}"
    @account = Account.find(params[:id])
    if @account
      render 'accounts/edit'
    else
      flash[:warning] = "Error finding account #{params[:id]}"
      halt 404
    end
  end

  put '/accounts/:id' do
    # Update an existing account
    @title = "Update Account #{params[:id]}"
    @account = Account.find(params[:id])
    if @account
      if @account.update_attributes(params[:account])
        flash[:success] = "Account #{params[:id]} successfully updated"
        params[:save_and_continue] ? redirect('/accounts') : redirect("/accounts/#{@account.id}/edit")
      else
        flash.now[:error] = "Error updating account"
        render 'accounts/edit'
      end
    else
      flash[:warning] = "Error finding account #{params[:id]}"
      halt 404
    end
  end

  delete '/accounts/:id' do
    # Delete an existing account
    @title = "Accounts"
    account = Account.find(params[:id])
    if account
      if account != current_account && account.destroy
        flash[:success] = "Account #{params[:id]} successfully deleted"
      else
        flash[:error] = "Error deleting account"
      end
      redirect '/accounts'
    else
      flash[:warning] = "Error finding account #{params[:id]}"
      halt 404
    end
  end

  delete '/accounts' do
    # Delete multiple accounts
    @title = "Accounts"
    unless params[:account_ids]
      flash[:error] = "Error deleting accounts"
      redirect('/accounts')
    end
    ids = params[:account_ids].split(',').map(&:strip)
    accounts = Account.find(ids)
    
    if accounts.include? current_account
      flash[:error] = "Error deleting account"
    elsif Account.destroy accounts
    
      flash[:success] = "Accounts #{ids.to_sentence} successfully deleted"
    end
    redirect '/accounts'
  end
end