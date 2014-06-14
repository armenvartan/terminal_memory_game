
module Viewer

  def start_screen
    clear_screen
    puts %Q(Welcome to the Memory Game:

You will be given a string of letters.
It will be your job to write back what those letters are.
The letters will stay on screen for 1 second,
and then you will have 3 more seconds to repeat the
letters in either upper or lower case.

Press enter to continue...)
  end

  def you_lose(final_score)
    clear_screen
    puts "Thanks for playing. Your score is #{score(final_score)}"
  end

end
