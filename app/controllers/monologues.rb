Monologues::App.controllers :monologues do


  get :index, cache: true do
    @title = "Shakespeare's Monologues"
    @monologues = Monologue.take(100)
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

      @title = "Monologues results for: #{params[:query]}"

      s = "%#{params[:query].to_s.downcase}%"
      @monologues = Monologue.limit(20).where(
          'first_line ILIKE ? OR character ILIKE ? OR body ILIKE ? OR location ILIKE ?',
          s, s, s, s
      )
      render 'monologues/index'

    end
  end

  get '/api/monologues' do
    binding.pry
    render 'errors/500', layout: false
  end

  post :api, map: '/api/monlogues', cache: true do
    begin

      logger.info "Monologues /api/monologues called with: #{params[:query]}"

      response = {}
      jdata = JSON.parse(params[:data], :symbolize_names => true)

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
