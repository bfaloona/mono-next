Monologues::App.controllers :plays do

  play_index = lambda do
    session[:gender] = gender_from_path || gender_letter(params[:g]) || session[:gender] || 'a'
    @title = "#{gender_word(session[:gender])} Monologues in Shakespeare"
    @plays = Play.all
    @comedies = Play.where(classification: 'Comedy')
    @histories = Play.where(classification: 'History')
    @tragedies = Play.where(classification: 'Tragedy')
    @scope = "#{gender_word(session[:gender])}"
    session[:play] = nil
    render 'plays/index'
  end

  get :root, map: '/', cache: true, &play_index
  get :index, map: '/plays', cache: true, &play_index
  get :monologues, map: '/monologues', cache: true, &play_index
  get :men, map: '/men', cache: true, &play_index
  get :women, map: '/women', cache: true, &play_index

  monologues_index = lambda do
    @play = Play.find(params[:id])
    session[:gender] = gender_from_path || gender_letter(params[:g]) || session[:gender] || 'a'
    @title = "#{gender_word(session[:gender])} Monologues in #{@play.title}"
    @scope = @play.title
    session[:play] = @play.id
    @monologues = @play.monologues.gender(session[:gender])
    @result_summary = "#{@monologues.count} of #{@monologues.count} monologues"
    render 'monologues/index'
  end

  get :show, map: "/plays/:id", cache: true, &monologues_index
  get :showwomen, map: "/women/plays/:id", cache: true, &monologues_index
  get :showmen, map: "/men/plays/:id", cache: true, &monologues_index

end
