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

  def one_round
    keep_going = true
    start_screen
    username = answer
    until keep_going == false do
      clear_screen
      add_letter(@letters)
      puts @letters.join
      wait
      clear_screen
      answer_timer
      keep_going = compare_answer(answer, @letters)
    end

    user_score = score(@letters)
    add_score(@scores, username, user_score)
    you_lose(username, user_score)
  end
end

game = MemoryGame.new('scores.db')

## TESTS ##
# p game.scores

# game.start_screen
# game.add_score(game.scores, "armen", 5)
p game.this_weeks_high_scores(game.scores)
# game.one_round
