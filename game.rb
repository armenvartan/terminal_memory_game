# require 'console'

class MemoryGame

  attr_reader :letters, :letter_array

  def initialize
    @letter_array = []
    @letters = ("A".."Z").to_a

  end

  def letter_string
    @letter_array.join
  end

  def random_letter
    @letters.sample
  end

  def add_letter
    @letter_array << random_letter
  end

  def compare(answer)
    answer.upcase == letter_string
  end
end

game = MemoryGame.new

## TESTS ##

# p game.letters
# p game.random_letter
game.add_letter
p game.letter_array
p game.letter_string
p game.compare("A")
# p game.clear_screen
