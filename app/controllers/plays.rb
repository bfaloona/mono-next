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
    session[:toggle] = (params[:expand] == '1') ? 'expand' : 'collapse'

    # Debug ouput, displayed in development env
    @debug_output = <<~DEBUGOUT
    play: #{session[:play]}<br/>
    gender: #{session[:gender]}<br/>
    toggle: #{session[:toggle]}<br/>
    title: #{@title}<br/>
    query: #{session[:query]}<br/>
    found: #{@monologues.count}<br/>
    displayed: #{@monologues.count}
    DEBUGOUT

    render 'monologues/index', locals: {toggle: session[:toggle]}
  end

  get :show, map: "/plays/:id", cache: true, &monologues_index
  get :showwomen, map: "/women/plays/:id", cache: true, &monologues_index
  get :showmen, map: "/men/plays/:id", cache: true, &monologues_index

  ###
  # Generate three case insensitive routes
  # for each entry in play_routes hash.
  # For example:
  #   /asyoulikeit
  #   /men/asyoulikeit
  #   /women/asyoulikeit

  # key: play route symbol
  # value: play id
  play_routes = {
    # As You Like It
    asyoulikeit: 1,
    # The Comedy of Errors
    errors: 2,
    # Cymbeline
    cymbeline: 3,
    # Love's Labour's Lost
    lll: 4,
    # The Merchant of Venice
    merchant: 5,
    # Much Ado About Nothing
    muchado: 6,
    # Twelfth Night, Or What You Will
    '12thnight': 8,
    # All's Well That Ends Well
    allswell: 9,
    # A Midsummer Night's Dream
    midsummer: 13,
    # Henry IV, Part 1
    henryivi: 19,
    # Antony and Cleopatra
    aandc: 29,
    # Hamlet
    hamlet: 31,
    # Lear
    kinglear: 32,
    # Macbeth
    macbeth: 33,
    # Othello
    othello: 34,
    # Romeo and Juliet
    randj: 35
  }
  play_routes.each do |play_key, play_id|
    play_path = "/#{play_key}"
    get(Regexp.new("#{play_path}", true)) { do_play(play_id)}
    # TODO: gender_id parameter hardcoded
    get(Regexp.new("/men#{play_path}", true)) { do_play(play_id, 3)}
    get(Regexp.new("/women#{play_path}", true)) { do_play(play_id, 2)}
  end

end
