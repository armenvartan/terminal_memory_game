require_relative 'console'
require_relative 'viewer'
require 'sqlite3'

class MemoryGame
  include Console
  include Viewer
  attr_accessor :letters, :scores

  def initialize(scores_database)
    @letters = []
    @scores = SQLite3::Database.open "#{scores_database}"
  end

  def play_timed_game #game currently gives you the total amount of time to play and doesn't refresh timer.
    keep_going = true
    start_screen
    username = answer
    until keep_going == false do
      clear_screen
      add_letter(@letters)

      puts @letters.join
      answers_in_time = Thread.new{ wait; clear_screen; keep_going = compare_answer(answer, @letters) }
      answers_too_slow = Thread.new{ answer_timer; keep_going = false; Thread.kill(answers_in_time) }
      answers_in_time.join
    end

    score_screen(username)
  end
end

game = MemoryGame.new('scores.db')

## TESTS ##
# p game.scores

# game.start_screen
# game.add_score(game.scores, "armen", 1)
# game.add_score(game.scores, "armen", 200)
# game.add_score(game.scores, "armen", 64)
# game.add_score(game.scores, "armen", 250)
# game.high_score_screen(game.this_weeks_high_scores(game.scores))
game.play_timed_game
