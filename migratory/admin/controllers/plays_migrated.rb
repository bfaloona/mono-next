
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

# Admin controller for Plays
get '/admin/plays' do
  @title = "Plays"
  @plays = Play.all
  erb :'plays/index'
end

# Show Monologues in Play
get '/admin/plays/:id' do
  @play = Play.find(params[:id])
  @title = "Monologues in #{@play.title}"
  @monologues = @play.monologues
  erb :'monologues/index'
end

# Create new Play
get '/admin/plays/new' do
  @title = "Create new Play"
  @play = Play.new
  erb :'plays/new'
end

# Post new Play
post '/admin/plays' do
  @play = Play.new(params[:play])
  if @play.save
    @title = "Play #{@play.id} created"
    flash[:success] = "Play created successfully"
    params[:save_and_continue] ? redirect('/admin/plays') : redirect("/admin/plays/#{@play.id}/edit")
  else
    @title = "Create new Play"
    flash.now[:error] = "Error creating Play"
    erb :'plays/new'
  end
end

# Edit Play
get '/admin/plays/:id/edit' do
  @title = "Edit Play #{params[:id]}"
  @play = Play.find(params[:id])
  if @play
    erb :'plays/edit'
  else
    flash[:warning] = "Error finding Play #{params[:id]}"
    halt 404
  end
end

# Update Play
put '/admin/plays/:id' do
  @title = "Play #{params[:id]} updated"
  @play = Play.find(params[:id])
  if @play
    if @play.update_attributes(params[:play])
      flash[:success] = "Play updated successfully"
      params[:save_and_continue] ? redirect('/admin/plays') : redirect("/admin/plays/#{@play.id}/edit")
    else
      flash.now[:error] = "Error updating Play"
      erb :'plays/edit'
    end
  else
    flash[:warning] = "Error finding Play #{params[:id]}"
    halt 404
  end
end

# Delete Play
delete '/admin/plays/:id' do
  @title = "Plays"
  play = Play.find(params[:id])
  if play
    if play.destroy
      flash[:success] = "Play #{params[:id]} deleted successfully"
    else
      flash[:error] = "Error deleting Play"
    end
    redirect '/admin/plays'
  else
    flash[:warning] = "Error finding Play #{params[:id]}"
    halt 404
  end
end

# Delete multiple Plays
delete '/admin/plays' do
  @title = "Plays"
  unless params[:play_ids]
    flash[:error] = "Error deleting Plays"
    redirect('/admin/plays')
  end
  ids = params[:play_ids].split(',').map(&:strip)
  plays = Play.find(ids)
  
  if Play.destroy plays
    flash[:success] = "Plays #{ids.to_sentence} deleted successfully"
  end
  redirect '/admin/plays'
end