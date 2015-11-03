Monologues::App.controllers :monologues do

  get :index do
    @title = "Shakespeare's Monologues"
    @monologues = Monologue.take(100)
    render 'monologues/index'
  end

  get :show, :map => "/monologues/:id" do
    @monologue = Monologue.find(params[:id])
    @title = @monologue.first_line
    render 'monologues/show'
  end



end
