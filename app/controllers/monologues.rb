Monologues::App.controllers :monologues do

  DISPLAY_LIMIT = 100

  get :show, map: "/monologues/:id", cache: false do
    begin
      @monologue = Monologue.find(params[:id])
      @title = "#{@monologue.character}'s \"#{@monologue.first_line}\" in #{@monologue.play.title}"
      session[:play] = nil

      if request.xhr?
        return @monologue.body
      else
        render 'monologues/show'
      end

    rescue ActiveRecord::RecordNotFound
      render 'errors/404', layout: false
    end
  end

  ###
  # Search
  ##

  post :search, map: '/search' do
    params = JSON.parse(request.env["rack.input"].read).symbolize_keys!
    default_params = {query: 'e', gender: 'a', play: 0, toggle: 'collapse'}
    params = default_params.merge(params)
    session[:gender] = params[:gender]
    session[:play] = params[:play].to_i rescue 0
    session[:query] = params[:query]
    session[:toggle] = params[:toggle]

    logger.info "Search controller: #{@title}"
    @show_play_title = true
    if session[:play] > 0
      @play = Play.find(session[:play])
      found_monologues = @play.monologues.gender(params[:gender]).matching(params[:query])
    else
      found_monologues = Monologue.gender(params[:gender]).matching(params[:query])
    end
    @monologues = found_monologues.take(DISPLAY_LIMIT)

    # Debug ouput, displayed in development env
    @debug_output = <<~DEBUGOUT
    play: #{session[:play]}<br/>
    gender: #{session[:gender]}<br/>
    toggle: #{session[:toggle]}<br/>
    query: #{session[:query]}<br/>
    found: #{found_monologues.count}<br/>
    displayed: #{@monologues.count}
    DEBUGOUT

    render 'monologues/_list', layout: false, locals: {toggle: session[:toggle]}
  end

end
