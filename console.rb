
module Console

  def clear_screen
    print "\e[2J\e[H"
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
    sleep(1.25)
  end

  def timer(time = @time)
    sleep(time.to_i)
  end

  def choose_game_mode
    puts "Would you like the timer set to 'game' or 'round'?"
    @game_mode = gets.chomp
    puts "Choose the timer time:"
    @time = gets.chomp
    puts "Get ready..."
    eval "self.timed_#{@game_mode}"
  end

  def score(letters)
    2 ** letters.length
  end

  def add_score(database, username, score, game_mode, timer)
    database.execute "INSERT INTO scores (user, score, game_mode, timer) VALUES (?, ?, ?, ?)",
    [username, score, game_mode, timer]
  end

  def this_weeks_high_scores(database)
    scores = database.execute "SELECT user, score, game_mode, timer, created_at FROM scores
    WHERE current_timestamp - created_at < 10"
    scores.sort!{ |low_scores, high_scores| high_scores[1] <=> low_scores[1]}
    scores.shift(5)
  end

  def score_screen(username)
    user_score = score(@letters)
    add_score(@scores, username, user_score, @game_mode, @time)
    you_lose(username, user_score)
    high_score_screen(this_weeks_high_scores(@scores))
  end
end
