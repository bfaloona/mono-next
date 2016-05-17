Monologues::App.controllers :monologues do

  DISPLAY_LIMIT = 50

  get :show, map: "/monologues/:id", cache: true do
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

    @title = "Monologues results for query '#{params[:query]}' and gender #{params[:gender]}}"
    logger.info "Search controller: #{@title}"
    @show_play_title = true
    if params[:play].to_i > 0
      play = Play.find(params[:play])
      found_monologues = play.monologues.gender(params[:gender]).matching(params[:query])
    else
      found_monologues = Monologue.gender(params[:gender]).matching(params[:query])
    end

    num_found = found_monologues.count
    @monologues = found_monologues.take(DISPLAY_LIMIT)
    @result_summary = "#{@monologues.count} of #{num_found} monologues"

    render 'monologues/_list', layout: false, locals: {toggle: params[:toggle]}
  end

end
