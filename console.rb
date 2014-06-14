
module Console

  def clear_screen
    puts "\e[H\e[2J"
  end

  def letter_string
    self.join
  end

  def random_letter
    self.sample
  end

  def add_letter
    self << random_letter
  end

  def compare(answer)
    answer.upcase == letter_string
  end


end
