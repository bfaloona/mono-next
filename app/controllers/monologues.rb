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
      @title = "Monologues results for: #{params[:query]}"

      s = "%#{params[:query].to_s.downcase}%"
      @monologues = Monologue.limit(20).where(
          'first_line ILIKE ? OR character ILIKE ? OR body ILIKE ? OR location ILIKE ?',
          s, s, s, s
      )
      render 'monologues/index'

    end
  end

end
