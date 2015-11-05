Monologues::App.controllers :monologues do

  get :mobile, map: '/m', cache: true do
    @title = "Shakespeare's Monologues"
    display_limit = 20
    num_found = Monologue.count
    @monologues = Monologue.take(display_limit)
    @result_summary = "#{num_found} found, #{@monologues.count} displayed"

    render 'monologues/mobile', layout: false
  end

  get :mobileshow, map: "/mobile/:id", cache: true do
    begin
      @monologue = Monologue.find(params[:id])
      @title = @monologue.first_line
      render 'monologues/show', layout: false

    rescue ActiveRecord::RecordNotFound
      render 'errors/404', layout: false
    end
  end

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

      @show_play_title = true
      @title = "Monologues results for: #{params[:query]}"


      s = "%#{params[:query].to_s.downcase}%"
      found_monologues = Monologue.where(
          'first_line ILIKE ? OR character ILIKE ? OR body ILIKE ? OR location ILIKE ?',
          s, s, s, s
      )
      display_limit = 50
      num_found = found_monologues.count
      @monologues = found_monologues.take(display_limit)
      @result_summary = "#{num_found} found, #{@monologues.count} displayed"
      render 'monologues/_list', layout: false

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
