
module Console

  def clear_screen
    print "\e[2J"
  end

  def random_letter
    ("A".."Z").to_a.sample
  end

  def add_letter(array)
    array.push(random_letter)
  end

  def answer
    answer = gets.chomp
  end

  def compare_answer(answer, letters)
    answer.upcase == letters.join
  end

  def wait
    sleep(1)
  end

  def answer_timer
    sleep(2)
  end

  def score(letters)
    2 ** letters.length
  end

end
