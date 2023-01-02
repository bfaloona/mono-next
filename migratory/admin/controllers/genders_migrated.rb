
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

require 'sinatra'

# Admin controller for managing genders
class Monologues::Admin::GendersController < Sinatra::Base
  # Get all genders
  get '/genders' do
    @title = "Genders"
    @genders = Gender.all
    erb :'genders/index'
  end

  # Create a new gender
  get '/genders/new' do
    @title = "New Gender"
    @gender = Gender.new
    erb :'genders/new'
  end

  # Create a new gender
  post '/genders' do
    @gender = Gender.new(params[:gender])
    if @gender.save
      @title = "Gender #{@gender.id} created"
      flash[:success] = "Gender #{@gender.id} created successfully"
      params[:save_and_continue] ? redirect('/genders') : redirect("/genders/#{@gender.id}/edit")
    else
      @title = "New Gender"
      flash.now[:error] = "Error creating gender"
      erb :'genders/new'
    end
  end

  # Edit a gender
  get '/genders/:id/edit' do
    @title = "Edit Gender #{params[:id]}"
    @gender = Gender.find(params[:id])
    if @gender
      erb :'genders/edit'
    else
      flash[:warning] = "Error finding gender #{params[:id]}"
      halt 404
    end
  end

  # Update a gender
  put '/genders/:id' do
    @title = "Update Gender #{params[:id]}"
    @gender = Gender.find(params[:id])
    if @gender
      if @gender.update_attributes(params[:gender])
        flash[:success] = "Gender #{params[:id]} updated successfully"
        params[:save_and_continue] ? redirect('/genders') : redirect("/genders/#{@gender.id}/edit")
      else
        flash.now[:error] = "Error updating gender"
        erb :'genders/edit'
      end
    else
      flash[:warning] = "Error finding gender #{params[:id]}"
      halt 404
    end
  end

  # Delete a gender
  delete '/genders/:id' do
    @title = "Genders"
    gender = Gender.find(params[:id])
    if gender
      if gender.destroy
        flash[:success] = "Gender #{params[:id]} deleted successfully"
      else
        flash[:error] = "Error deleting gender"
      end
      redirect '/genders'
    else
      flash[:warning] = "Error finding gender #{params[:id]}"
      halt 404
    end
  end

  # Delete multiple genders
  delete '/genders' do
    @title = "Genders"
    unless params[:gender_ids]
      flash[:error] = "Error deleting genders"
      redirect('/genders')
    end
    ids = params[:gender_ids].split(',').map(&:strip)
    genders = Gender.find(ids)
    
    if Gender.destroy genders
      flash[:success] = "Genders #{ids.to_sentence} deleted successfully"
    end
    redirect '/genders'
  end
end