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

  # play_routes hash
  # key: play route symbol
  # value: play id
  # comment: title
  play_routes = {
    asyoulikeit:    1,  # As You Like It
    coe:         2,  # The Comedy of Errors
    cymbeline:      3,  # Cymbeline
    lll:            4,  # Love's Labour's Lost
    merchant:       5,  # The Merchant of Venice
    muchado:        6,  # Much Ado About Nothing
    shrew:          7,  # The Taming of the Shrew
    '12thnight':    8,  # Twelfth Night, Or What You Will
    allswell:       9,  # All's Well That Ends Well
    measure:       10,  # Measure for Measure
    merrywives:    11,  # Merry Wives of Windsor
    merchent:      12,  # Merchant of Venice
    midsummer:     13,  # A Midsummer Night's Dream
    tempest:       14,  # The Tempest
    troilus:       15,  # Troilus and Cressida
    twogents:      16,  # Two Gentlemen of Verona
    winterstale:   17,  # The Winter's Tale
    pericles:      18,  # Pericles Prince of Tyre
    'henryiv-i':   19,  # Henry IV, Part 1
    'henryiv-ii':  20,  # Henry IV, Part 2
    henryv:        21,  # Henry V
    'henryvi-i':   22,  # Henry VI, Part 1
    'henryvi-ii':  23,  # Henry VI, Part 2
    'henryvi-iii': 24,  # Henry VI, Part 3
    henryviii:     25,  # Henry VIII
    kingjohn:      26,  # King John
    richardii:     27,  # Richard II
    richardiii:    28,  # Richard III
    aandc:         29,  # Antony and Cleopatra
    coriolanus:    30,  # Coriolanus
    hamlet:        31,  # Hamlet
    lear:          32,  # Lear
    macbeth:       33,  # Macbeth
    othello:       34,  # Othello
    randj:         35,  # Romeo and Juliet
    timon:         36,  # Timon of Athens
    titus:         37,  # Titus Andronicus
    caesar:        38   # Julius Caesar
  }
  play_routes.each do |play_key, play_id|
    play_path = "/#{play_key}/?"
    get(Regexp.new("#{play_path}", true)) { do_play(play_id)}
    # TODO: gender_id parameter hardcoded
    get(Regexp.new("/men#{play_path}/?", true)) { do_play(play_id, 3)}
    get(Regexp.new("/women#{play_path}/?", true)) { do_play(play_id, 2)}
    get(Regexp.new("/plays#{play_path}/?", true)) { do_play(play_id)}
  end

end
