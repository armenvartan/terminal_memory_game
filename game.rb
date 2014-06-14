require_relative 'console'
require_relative 'viewer'

class MemoryGame
  include Console
  include Viewer
  attr_reader :letters

  def initialize
    @letters = []
  end

  def one_round
    keep_going = true
    until keep_going == false do
      clear_screen
      add_letter(@letters)
      puts @letters.join
      wait
      clear_screen
      keep_going = compare_answer(answer, @letters)
      clear_mind
    end
    you_lose(@letters)
  end

end

game = MemoryGame.new

## TESTS ##

# p game.letters
# p game.random_letter
# p game.add_letter(game.letters)
# p game.to_string(game.letters)
# p game.compare("A", game.letters)
# p game.clear_screen
game.start_screen
game.answer
game.one_round
