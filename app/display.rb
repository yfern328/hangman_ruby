class DisplayMessage

  def initialize
    puts "WELCOME TO HANGMAN!"
    puts "Enter 'help' for help menu"
    puts "Enter 'stats' for stats"
    puts "Enter 'profile' if you want to make or select a user profile"
    puts "Single Player? or Two Player?"
  end

  def self.clear
    system "clear"
  end

  def self.pictures(guesses)
    if guesses == 6
      puts "   _____"
      puts "   |    |"
      puts "        |"
      puts "        |"
      puts "        |"
      puts "        | "
      puts "    ========="
    elsif guesses == 5
      puts "   _____"
      puts "   |    |"
      puts "   O    |"
      puts "        |"
      puts "        |"
      puts "        | "
      puts "    ========="
    elsif guesses == 4
      puts "   _____"
      puts "   |    |"
      puts "   O    |"
      puts "   |    |"
      puts "        |"
      puts "        | "
      puts "    ========="
    elsif guesses == 3
      puts "   _____"
      puts "   |    |"
      puts "   O    |"
      puts "  -|    |"
      puts "        |"
      puts "        | "
      puts "    ========="
    elsif guesses == 2
      puts "   _____"
      puts "   |    |"
      puts "   O    |"
      puts "  -|-   |"
      puts "        |"
      puts "        | "
      puts "    ========="
    elsif guesses == 1
      puts "   _____"
      puts "   |    |"
      puts "   O    |"
      puts "  -|-   |"
      puts "  /     |"
      puts "        | "
      puts "    ========="
    elsif guesses == 0
      puts "   _____"
      puts "   |    |"
      puts "   O    |"
      puts "  -|-   |"
      puts "  / \\   |"
      puts "        | "
      puts "    ========="
      puts "    GAME OVER"
    end
  end
end
