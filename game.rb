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

  def start_game
    start_screen
    @username = gets.chomp
    choose_game_mode
  end

  def timed_game #where timer is for the total game
    keep_going = true

    until keep_going == false do
      clear_screen
      add_letter(@letters)
      puts @letters.join

      answers_in_time = Thread.new{ wait; clear_screen; keep_going = compare_answer(answer, @letters) }
      answers_too_slow = Thread.new{ timer; keep_going = false; Thread.kill(answers_in_time) }
      answers_in_time.join
    end

    score_screen(@username)
  end

  def timed_round
    keep_going = true

    # until keep_going == false do
    #   clear_screen
    #   add_letter(@letters)
    #   puts @letters.join
    #
    #   answers_in_time = Thread.new do
    #     wait
    #     clear_screen
    #     compare_answer(answer, @letters) ? timed_round : keep_going = false
    #     Thread.kill(answers_too_slow)
    #   end
    #   answers_too_slow = Thread.new do
    #     timer
    #     Thread.kill(answers_in_time)
    #     keep_going = false
    #   end
    #   answers_in_time.join
    # end

    until keep_going == false do
      clear_screen
      add_letter(@letters)
      puts @letters.join

      answers_in_time = Thread.new{ wait; clear_screen; keep_going = compare_answer(answer, @letters); Thread.kill(answers_too_slow) }
      answers_too_slow = Thread.new{ timer; keep_going = false; Thread.kill(answers_in_time) }
      answers_in_time.join
    end

    score_screen(@username)
    sleep(2)
  end
end

game = MemoryGame.new('scores.db')

## DRIVER CODE ##

game.start_game

## TESTS ##
# p game.scores
# game.start_game
# game.add_score(game.scores, "armen", 1)
# game.add_score(game.scores, "armen", 200)
# game.add_score(game.scores, "armen", 64)
# game.add_score(game.scores, "armen", 250)
# game.high_score_screen(game.this_weeks_high_scores(game.scores))
# game.start_game
