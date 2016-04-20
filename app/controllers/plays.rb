Monologues::App.controllers :plays do
  
  get :index, cache: true do
    @title = "Plays"
    @plays = Play.all
    session[:play] = nil
    @comedies = Play.where(classification: 'Comedy')
    @histories = Play.where(classification: 'History')
    @tragedies = Play.where(classification: 'Tragedy')
    session[:gender] = 'a'
    render 'plays/index'
  end

  get :show, :map => "/plays/:id", cache: true do
    begin
      @play = Play.find(params[:id])
      session[:gender] = gender_letter(params[:g])
      @title = "#{@play.title} - #{gender_word(session[:gender])} monologues"
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
