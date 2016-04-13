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
      @scope = @play.title
      session[:play] = @play.id

      display_limit = 50

      query_param = "%#{params[:query].to_s.strip.downcase}%"

      found_monologues = @play.monologues.gender(session[:gender]).matching(query_param)

      num_found = found_monologues.count
      @monologues = found_monologues.take(display_limit)
      @result_summary = "#{@monologues.count} of #{num_found} monologues"

      render 'monologues/index'

    rescue ActiveRecord::RecordNotFound
      render 'errors/404', layout: false
    end

  end

end
