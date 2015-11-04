Monologues::App.controllers :plays do
  
  get :index do
    @title = "Shakespeare's Monologues"
    @plays = Play.all
    @comedies = Play.where(classification: 'Comedy')
    @histories = Play.where(classification: 'History')
    @tragedies = Play.where(classification: 'Tragedy')
    render 'plays/index'
  end

  get :show, :map => "/plays/:id" do
    begin
      @play = Play.find(params[:id])
      @title = @play.title
      @monologues = Monologue.where(play_id: params[:id])
      render 'plays/show'

    rescue
      if !@play
        # requested play does not exist
        render 'errors/404', layout: false
      else
        render 'errors/500', layout: false
      end
    end

  end

end
