Monologues::Admin.controllers :plays do
  get :index do
    @title = "Plays"
    @plays = Play.all
    render 'plays/index'
  end

  get :show, with: :id do
    @play = Play.find(params[:id])
    @title = "Monologues in #{@play.title}"
    @monologues = @play.monologues
    render 'monologues/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'play')
    @play = Play.new
    render 'plays/new'
  end

  post :create do
    @play = Play.new(params[:play])
    if @play.save
      @title = pat(:create_title, :model => "play #{@play.id}")
      flash[:success] = pat(:create_success, :model => 'Play')
      params[:save_and_continue] ? redirect(url(:plays, :index)) : redirect(url(:plays, :edit, :id => @play.id))
    else
      @title = pat(:create_title, :model => 'play')
      flash.now[:error] = pat(:create_error, :model => 'play')
      render 'plays/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "play #{params[:id]}")
    @play = Play.find(params[:id])
    if @play
      render 'plays/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'play', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "play #{params[:id]}")
    @play = Play.find(params[:id])
    if @play
      if @play.update_attributes(params[:play])
        flash[:success] = pat(:update_success, :model => 'Play', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:plays, :index)) :
          redirect(url(:plays, :edit, :id => @play.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'play')
        render 'plays/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'play', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Plays"
    play = Play.find(params[:id])
    if play
      if play.destroy
        flash[:success] = pat(:delete_success, :model => 'Play', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'play')
      end
      redirect url(:plays, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'play', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Plays"
    unless params[:play_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'play')
      redirect(url(:plays, :index))
    end
    ids = params[:play_ids].split(',').map(&:strip)
    plays = Play.find(ids)
    
    if Play.destroy plays
    
      flash[:success] = pat(:destroy_many_success, :model => 'Plays', :ids => "#{ids.to_sentence}")
    end
    redirect url(:plays, :index)
  end
end
