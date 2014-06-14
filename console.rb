
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

  def add_score(database, username, score)
    database.execute "INSERT INTO scores (user, score) VALUES (?, ?)", [username, score]
  end

  def this_weeks_high_scores(database)
    scores = database.execute "SELECT user, score, created_at FROM scores
    WHERE current_timestamp - created_at < 10"
    scores.sort!{ |low_scores, high_scores| high_scores[1] <=> low_scores[1]}
    scores.shift(5)
  end

end
