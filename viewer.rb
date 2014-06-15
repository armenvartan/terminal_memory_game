
module Viewer

  def start_screen
    clear_screen
    puts %Q(Welcome to the Memory Game:

You will be given a string of letters.
It will be your job to write back what those letters are.
The letters will stay on screen for 1 second,
and then you will have 3 more seconds to repeat the
letters in either upper or lower case.

Enter your user name to start...)
  end

  def you_lose(username,final_score)
    clear_screen
    puts "Thanks for playing, #{username}. Your score is #{final_score}"
  end

  def high_score_screen(high_scores)
    puts "\n"
    puts "High scores this week:"
    high_scores.each do |high_score|
      puts "#{high_score[0]}: #{high_score[1]} points, #{high_score[2]}, timer: #{high_score[3]} seconds, on #{high_score[4]}"
    end
  end

end
