Monologues::App.controllers :monologues do

  DISPLAY_LIMIT = 50

  monologue_index = lambda do
    session[:gender] = request.path_info[1]
    @title = "#{gender_word(session[:gender])} Monologues in Shakespeare"
    num_found = Monologue.count
    @plays = Play.all
    session[:play] = nil
    @comedies = Play.where(classification: 'Comedy')
    @histories = Play.where(classification: 'History')
    @tragedies = Play.where(classification: 'Tragedy')
    @scope = "#{gender_word(session[:gender])}"
    session[:play] = nil

    render 'plays/index'
  end

  get :index, map: '/', cache: true, &monologue_index
  get :index, map: '/monologues', cache: true, &monologue_index
  get :men, map: '/men', cache: true, &monologue_index
  get :women, map: '/women', cache: true, &monologue_index

  get :show, map: "/monologues/:id", cache: true do
    begin
      @monologue = Monologue.find(params[:id])
      @title = "#{@monologue.first_line[0..20]}"
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
    default_params = {query: 'e', gender: 'a', play: '', toggle: 'collapse'}
    params = default_params.merge(params)

    @title = "Monologues results for query '#{params[:query]}' and gender #{params[:gender]}}"
    logger.info "Search controller: #{@title}"

    @show_play_title = true
    if (params[:play].length > 0)
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


  ##
  # Mobile
  #

  get :mobile, map: '/m', cache: true do
    @title = "Shakespeare's Monologues"
    num_found = Monologue.count
    @monologues = Monologue.take(DISPLAY_LIMIT)
    @result_summary = "#{@monologues.count} of #{num_found} monologues"
    @show_play_title = true
    render 'mobile/index', layout: :mobile
  end

  get :mobileshow, map: "/m/:id", cache: true do
    begin
      @monologue = Monologue.find(params[:id])
      @title = @monologue.first_line
      render 'mobile/monologue', layout: :mobile
    end
  end

  get :mobileplay, map: "/p/:id", cache: true do
    begin
      @play = Play.find(params[:id])
      @title = @play.title
      @monologues = Monologue.where(play_id: params[:id])
      @result_summary = "#{@monologues.count} monologues"
      @show_play_title = false
      render 'mobile/play', layout: :mobile
    end
  end


  ###
  # API
  ##

  get '/api/monologues' do
    render 'errors/500', layout: false
  end

  post :api, map: '/api/monologues' do

    begin

      logger.info "Monologues /api/monologues called with: #{params[:query]}"

      response = {}
      jdata = JSON.parse(params[:data], symbolize_names: true)

      s = "%#{jdata[query].downcase}%"
      monologues = Monologue.limit(20).where(
          'first_line ILIKE ? OR character ILIKE ? OR body ILIKE ? OR location ILIKE ?',
          s, s, s, s
      )

      response[:data] = monologues.to_json
      response

    end
  end


end
