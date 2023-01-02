
            #
 # This file was originally written for Padrino 0.13 by
 # Brandon Faloona, then migrated to Sinatra 3.0.5 by
 # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
 # December 2022.
 #

# Monologues Admin Controller
# This controller handles the routes for the Admin side of the Monologues application.

class MonologuesAdminController < Sinatra::Base

  # Index
  # This route renders the index page of the Monologues application.
  # It displays the title, and the first 20 monologues.
  get '/monologues' do
    @title = "Monologues (well 20 of them)"
    @monologues = Monologue.limit(20)
    erb :'monologues/index'
  end

  # Men
  # This route renders the Men's Monologues page.
  # It displays the title, and the monologues with a gender of 3.
  get '/monologues/men' do
    @title = 'Only Men\'s Monologues'
    @monologues = Monologue.where(gender: 3)
    erb :'monologues/index'
  end

  # Women
  # This route renders the Women's Monologues page.
  # It displays the title, and the monologues with a gender of 2.
  get '/monologues/women' do
    @title = 'Only Women\'s Monologues'
    @monologues = Monologue.where(gender: 2)
    erb :'monologues/index'
  end

  # Both
  # This route renders the Both Gender Monologues page.
  # It displays the title, and the monologues with a gender of 1.
  get '/monologues/both' do
    @title = 'Only Both Gender Monologues'
    @monologues = Monologue.where(gender: 1)
    erb :'monologues/index'
  end

  # New
  # This route renders the new Monologue page.
  # It displays the title and a form to create a new monologue.
  get '/monologues/new' do
    @title = pat(:new_title, :model => 'monologue')
    @monologue = Monologue.new
    erb :'monologues/new'
  end

  # Create
  # This route creates a new Monologue.
  # It creates a new monologue with the parameters passed in,
  # then redirects to the index page or the edit page.
  post '/monologues' do
    @monologue = Monologue.new(params[:monologue])
    if @monologue.save
      @title = pat(:create_title, :model => "monologue #{@monologue.id}")
      flash[:success] = pat(:create_success, :model => 'Monologue')
      params[:save_and_continue] ? redirect(url(:monologues, :index)) : redirect(url(:monologues, :edit, :id => @monologue.id))
    else
      @title = pat(:create_title, :model => 'monologue')
      flash.now[:error] = pat(:create_error, :model => 'monologue')
      erb :'monologues/new'
    end
  end

  # Edit
  # This route renders the edit Monologue page.
  # It displays the title and a form to edit an existing monologue.
  get '/monologues/:id/edit' do
    @title = pat(:edit_title, :model => "monologue #{params[:id]}")
    @monologue = Monologue.find(params[:id])
    if @monologue
      erb :'monologues/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'monologue', :id => "#{params[:id]}")
      halt 404
    end
  end

  # Update
  # This route updates an existing Monologue.
  # It updates the monologue with the parameters passed in,
  # then redirects to the index page or the edit page.
  put '/monologues/:id' do
    @title = pat(:update_title, :model => "monologue #{params[:id]}")
    @monologue = Monologue.find(params[:id])
    if @monologue
      if @monologue.update_attributes(params[:monologue])
        flash[:success] = pat(:update_success, :model => 'Monologue', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:monologues, :index)) :
          redirect(url(:monologues, :edit, :id => @monologue.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'monologue')
        erb :'monologues/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'monologue', :id => "#{params[:id]}")
      halt 404
    end
  end

  # Destroy
  # This route deletes a Monologue.
  # It deletes the monologue with the id passed in,
  # then redirects to the index page.
  delete '/monologues/:id' do
    @title = "Monologues"
    monologue = Monologue.find(params[:id])
    if monologue
      if monologue.destroy
        flash[:success] = pat(:delete_success, :model => 'Monologue', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'monologue')
      end
      redirect url(:monologues, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'monologue', :id => "#{params[:id]}")
      halt 404
    end
  end

  # Destroy Many
  # This route deletes multiple Monologues.
  # It deletes the monologues with the ids passed in,
  # then redirects to the index page.
  delete '/monologues' do
    @title = "Monologues"
    unless params[:monologue_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'monologue')
      redirect(url(:monologues, :index))
    end
    ids = params[:monologue_ids].split(',').map(&:strip)
    monologues = Monologue.find(ids)
    
    if Monologue.destroy monologues
    
      flash[:success] = pat(:destroy_many_success, :model => 'Monologues', :ids => "#{ids.to_sentence}")
    end
    redirect url(:monologues, :index)
  end

end