Monologues::App.controllers :plays do
  
  get :index, cache: true do
    @title = "Shakespeare's Monologues"
    @plays = Play.all
    @comedies = Play.where(classification: 'Comedy')
    @histories = Play.where(classification: 'History')
    @tragedies = Play.where(classification: 'Tragedy')
    render 'plays/index'
  end

  get :show, :map => "/plays/:id", cache: true do
    begin
      @play = Play.find(params[:id])
      @title = @play.title
      @monologues = Monologue.where(play_id: params[:id])
      render 'plays/show'

    rescue ActiveRecord::RecordNotFound
      render 'errors/404', layout: false
    end

  end

end
