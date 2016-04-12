Monologues::App.controllers :monologues do

  get :index, map: '/', cache: true do
    @title = "Shakespeare's Monologues"
    display_limit = 50
    num_found = Monologue.count
    @monologues = Monologue.take(display_limit)
    @result_summary = "#{@monologues.count} of #{num_found} monologues"

    render 'monologues/index'
  end

  get :show, map: "/monologues/:id", cache: true do
    begin
      @monologue = Monologue.find(params[:id])
      @title = @monologue.first_line

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

      gender_param = params[:gender]
      logger.info "Monologues controller called with query '#{params[:query]}' and gender #{gender_param}"
      is_mobile = request.referer.match(/\/m$/) rescue false

      @show_play_title = true
      @title = "Monologues results for query '#{params[:query]}' and gender #{gender_param}}"

      s = "%#{params[:query].to_s.strip.downcase}%"

      # TODO Gender state is too complicated!
      # 'Both' and All should be the same case, but it's not.
      case gender_param
        when 'a', '', nil
          found_monologues = Monologue
                               .where( 'first_line ILIKE ? OR character ILIKE ?
                                        OR body ILIKE ? OR location ILIKE ?',
                                        s, s, s, s)
        when 'w', 'm'
          gender_id = gender_param.match(/^w$/) ? '2' : '3'
          found_monologues = Monologue
                                 .where(gender: gender_id)
                                 .where( 'first_line ILIKE ? OR character ILIKE ?
                                      OR body ILIKE ? OR location ILIKE ?',
                                         s, s, s, s)
        else
          halt 500, 'Unable to set the gender params value'
      end

      display_limit = is_mobile ? 20 : 50
      num_found = found_monologues.count
      @monologues = found_monologues.take(display_limit)
      @result_summary = "#{@monologues.count} of #{num_found} monologues"

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
