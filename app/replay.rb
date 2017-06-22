require_relative '../app/hangman.rb'

class Replay

  attr_accessor :count

  $quit = false
  $name = ""

  def initialize

    @count = 0
    DisplayMessage.clear
    while $quit == false
      if @count == 0
        puts "Type 'play' to start Hangman or 'quit' to leave game."
      else
        puts "Type 'play' to start Hangman again or 'quit' to leave game."
      end
      input = gets.chomp
      @count += 1
      input.downcase!
      if input == "play" || input == "begin" || input == "start"
        Hangman.new
      elsif input == "quit"
        puts "Ciao"
        $quit = true
      else
        puts "Invalid Entry..."
        puts "try 'play'"
      end
    end

  end

end
