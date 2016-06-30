Monologues::App.controllers :plays do

  play_index = lambda do
    session[:gender] = gender_from_path || gender_letter(params[:g]) || 'a'
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
    @play = Play.find(params[:id].to_i)
    session[:play] = @play.id
    session[:gender] = gender_from_path || gender_letter(params[:g]) || 'a'
    @title = "#{gender_word(session[:gender])} Monologues in #{@play.title}"
    @monologues = @play.monologues.gender(session[:gender])
    @result_summary = "#{@monologues.count} of #{@monologues.count} monologues"
    session[:toggle] = (params[:expand] == '1') ? 'expand' : 'collapse'

    render 'monologues/index', locals: {toggle: session[:toggle]}
  end

  get :show, map: "/plays/:id", cache: true, &monologues_index
  get :showwomen, map: "/women/plays/:id", cache: true, &monologues_index
  get :showmen, map: "/men/plays/:id", cache: true, &monologues_index

end
