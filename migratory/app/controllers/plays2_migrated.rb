
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            # This file contains a hash of plays and the corresponding ids, and routes to handle requests for those plays. 
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
            
            # Iterate through the play_routes hash and create routes for each play
            play_routes.each do |play_key, play_id|
              play_path = "/#{play_key}/?"
              # Create a route for the play
              get(Regexp.new(play_path, true)) { do_play(play_id)}
              # Create a route for the play with the gender_id parameter set to 3
              get(Regexp.new("/men#{play_path}/?", true)) { do_play(play_id, 3)}
              # Create a route for the play with the gender_id parameter set to 2
              get(Regexp.new("/women#{play_path}/?", true)) { do_play(play_id, 2)}
              # Create a route for the play with the gender_id parameter set to nil
              get(Regexp.new("/plays#{play_path}/?", true)) { do_play(play_id)}
            end