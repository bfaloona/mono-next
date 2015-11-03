Monologues::Admin.controllers :monologues do
  get :index do
    @title = "Monologues (well 20 of them)"
    @monologues = Monologue.take(20)
    render 'monologues/index'
  end

  get :men do
    @title = 'Men\'s Monologues'
    @monologues = Monologue.where(gender: 3)
    render 'monologues/index'
  end

  get :women do
    @title = 'Women\'s Monologues'
    @monologues = Monologue.where(gender: 2)
    render 'monologues/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'monologue')
    @monologue = Monologue.new
    render 'monologues/new'
  end

  post :create do
    @monologue = Monologue.new(params[:monologue])
    if @monologue.save
      @title = pat(:create_title, :model => "monologue #{@monologue.id}")
      flash[:success] = pat(:create_success, :model => 'Monologue')
      params[:save_and_continue] ? redirect(url(:monologues, :index)) : redirect(url(:monologues, :edit, :id => @monologue.id))
    else
      @title = pat(:create_title, :model => 'monologue')
      flash.now[:error] = pat(:create_error, :model => 'monologue')
      render 'monologues/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "monologue #{params[:id]}")
    @monologue = Monologue.find(params[:id])
    if @monologue
      render 'monologues/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'monologue', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
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
        render 'monologues/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'monologue', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
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

  delete :destroy_many do
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
