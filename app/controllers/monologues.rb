Monologues::App.controllers :monologues do

    DISPLAY_LIMIT = 50

  get :index, map: '/', cache: true do
    @title = "Shakespeare's Monologues"
    num_found = Monologue.count
    @monologues = Monologue.take(DISPLAY_LIMIT)
    @result_summary = "#{@monologues.count} of #{num_found} monologues"
    @scope = "Shakespeare's"
    session[:play] = nil

    render 'monologues/index'
  end

  get :show, map: "/monologues/:id", cache: true do
    begin
      @monologue = Monologue.find(params[:id])
      @title = @monologue.first_line
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

  get :search, map: '/search', with: [ :query, '(:gender)'], cache: true do
    begin
      @title = "Monologues results for query '#{params[:query]}' and gender #{params[:gender]}}"
      logger.info "Search controller: #{@title}"

      @show_play_title = true

      if session[:play]
        play = Play.find(session[:play])
        found_monologues = play.monologues.gender(params[:gender]).matching(params[:query])
      else
        found_monologues = Monologue.gender(params[:gender]).matching(params[:query])
      end

      num_found = found_monologues.count
      @monologues = found_monologues.take(DISPLAY_LIMIT)
      @result_summary = "#{@monologues.count} of #{num_found} monologues"

      render 'monologues/_list', layout: false
    end
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

  post :api, map: '/api/monlogues' do

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
