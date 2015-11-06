Monologues::App.controllers :monologues do

  get :index, map: '/', cache: true do
    @title = "Shakespeare's Monologues"
    display_limit = 50
    num_found = Monologue.count
    @monologues = Monologue.take(display_limit)
    @result_summary = "#{num_found} found, #{@monologues.count} displayed"

    render 'monologues/index'
  end

  get :show, map: "/monologues/:id", cache: true do
    begin
      @monologue = Monologue.find(params[:id])
      @title = @monologue.first_line
      render 'monologues/show'

    rescue ActiveRecord::RecordNotFound
      render 'errors/404', layout: false
    end
  end

  get :index, map: '/search/:query', cache: true do
    begin

      logger.info "Monologues controller called with: #{params[:query]}"
      is_mobile = request.referer.match(/\/m$/) rescue false

      @show_play_title = true
      @title = "Monologues results for: #{params[:query]}"


      s = "%#{params[:query].to_s.downcase}%"
      found_monologues = Monologue.where(
          'first_line ILIKE ? OR character ILIKE ? OR body ILIKE ? OR location ILIKE ?',
          s, s, s, s
      )

      display_limit = is_mobile ? 20 : 50
      num_found = found_monologues.count
      @monologues = found_monologues.take(display_limit)
      @result_summary = "#{num_found} found, #{@monologues.count} displayed"

      if is_mobile
        render 'mobile/_list', layout: false
      else
        render 'monologues/_list', layout: false
      end


    end
  end


  ##
  # Mobile
  #

  get :mobile, map: '/m', cache: true do
    @title = "Shakespeare's Monologues"
    display_limit = 20
    num_found = Monologue.count
    @monologues = Monologue.take(display_limit)
    @result_summary = "#{num_found} found, #{@monologues.count} displayed"
    @show_play_title = true
    render 'mobile/index', layout: false
  end

  get :mobileshow, map: "/m/:id", cache: true do
    begin
      @monologue = Monologue.find(params[:id])
      @title = @monologue.first_line
      render 'mobile/monologue', layout: false
    end
  end

  get :mobileplay, map: "/p/:id", cache: true do
    begin
      @play = Play.find(params[:id])
      @title = @play.title
      @monologues = Monologue.where(play_id: params[:id])
      @result_summary = "#{@monologues.count} found"
      @show_play_title = false
      render 'mobile/play', layout: false
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
