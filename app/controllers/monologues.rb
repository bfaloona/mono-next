Monologues::App.controllers :monologues do

  get :index do
    @title = "Shakespeare's Monologues"
    @monologues = Monologue.take(100)
    render 'monologues/index'
  end

  get :show, :map => "/monologues/:id" do
    begin
      @monologue = Monologue.find(params[:id])
      @title = @monologue.first_line
      render 'monologues/show'

    rescue
      if !@monologue
        # requested monologue does not exist
        render 'errors/404', layout: false
      else
        render 'errors/500', layout: false
      end

    end

  end
end
