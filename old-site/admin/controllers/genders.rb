Monologues::Admin.controllers :genders do
  get :index do
    @title = "Genders"
    @genders = Gender.all
    render 'genders/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'gender')
    @gender = Gender.new
    render 'genders/new'
  end

  post :create do
    @gender = Gender.new(params[:gender])
    if @gender.save
      @title = pat(:create_title, :model => "gender #{@gender.id}")
      flash[:success] = pat(:create_success, :model => 'Gender')
      params[:save_and_continue] ? redirect(url(:genders, :index)) : redirect(url(:genders, :edit, :id => @gender.id))
    else
      @title = pat(:create_title, :model => 'gender')
      flash.now[:error] = pat(:create_error, :model => 'gender')
      render 'genders/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "gender #{params[:id]}")
    @gender = Gender.find(params[:id])
    if @gender
      render 'genders/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'gender', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "gender #{params[:id]}")
    @gender = Gender.find(params[:id])
    if @gender
      if @gender.update_attributes(params[:gender])
        flash[:success] = pat(:update_success, :model => 'Gender', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:genders, :index)) :
          redirect(url(:genders, :edit, :id => @gender.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'gender')
        render 'genders/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'gender', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Genders"
    gender = Gender.find(params[:id])
    if gender
      if gender.destroy
        flash[:success] = pat(:delete_success, :model => 'Gender', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'gender')
      end
      redirect url(:genders, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'gender', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Genders"
    unless params[:gender_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'gender')
      redirect(url(:genders, :index))
    end
    ids = params[:gender_ids].split(',').map(&:strip)
    genders = Gender.find(ids)
    
    if Gender.destroy genders
    
      flash[:success] = pat(:destroy_many_success, :model => 'Genders', :ids => "#{ids.to_sentence}")
    end
    redirect url(:genders, :index)
  end
end
