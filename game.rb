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
    @user_name = ""
  end

  def play_game
    start_screen
    @username = gets.chomp
    choose_game_mode
    score_screen(@username)
    sleep(1)
  end

  def timed_game #where timer is for the total game
    keep_going = true

    until keep_going == false do
      letter_adder_supreme

      answers_in_time = Thread.new{ wait; clear_screen; keep_going = compare_answer(answer, @letters) }
      answers_too_slow = Thread.new{ timer; keep_going = false; Thread.kill(answers_in_time) }
      answers_in_time.join
    end
  end

  def timed_round # where timer is for the round time
    keep_going = true

    until keep_going == false do
      letter_adder_supreme

      answers_in_time = Thread.new{ wait; clear_screen; keep_going = compare_answer(answer, @letters) }
      answers_too_slow = Thread.new{ timer; keep_going = false; Thread.kill(answers_in_time) }
      answers_in_time.join
      Thread.kill(answers_too_slow)
    end
  end
end

game = MemoryGame.new('scores.db')

## DRIVER CODE ##

game.play_game

## TESTS ## # I should have kept all of my tests to show. sorry for deleting some of them

# p game.scores
# game.start_game
# game.add_score(game.scores, "armen", 1)
# game.add_score(game.scores, "armen", 200)
# game.add_score(game.scores, "armen", 64)
# game.add_score(game.scores, "armen", 250)
# game.high_score_screen(game.this_weeks_high_scores(game.scores))
# game.start_game
