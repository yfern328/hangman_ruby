require 'io/console'
require_relative "replay.rb"
require_relative "games.rb"
require_relative "display.rb"
require "pry"
#require 'io/wait'

class Hangman

  attr_accessor :word, :game_in_session, :guesses, :input, :guessed_letters, :remaining_letters, :temp_word, :blanks_to_fill, :list_of_words, :count, :game_result, :game, :name

  @@all = []

  def initialize
    DisplayMessage.clear
    @guesses = 6
    @game_in_session = false
    @guessed_letters = []
    @remaining_letters = ("a".."z").to_a
    @list_of_words = ["elevator", 'willie wonka', 'donkey kong', 'flatiron', 'hash me outside', 'i am your father', 'catch me if you can', 'laundry', 'the eagle has landed', 'build me up buttercup', 'qat']
    @input = ""
    @count = 0
    DisplayMessage.pictures(@guesses)
    DisplayMessage.new
    single_or_double(gets.chomp)
  end

  def single_or_double(input)
    input.downcase!
    check_input(input)
  end

  def check_input(input)
    @input = input.downcase
    if (input == 'single' || input == '1' || input == 'single player') && !@game_in_session
        DisplayMessage.clear
        @game_in_session = true
        single
    elsif (input == 'double' || input == '2' || input == 'two player') && !@game_in_session
        DisplayMessage.clear
        @game_in_session = true
        double
    elsif input == 'quit' || input == 'exit'
      $quit = true
      @game_in_session = false
      puts "Ciao"
    # elsif input == 'help'  && !@game_in_session
    #   puts 'help in progress'
    elsif input == 'profile' && !@game_in_session
        p "Enter a name"
        user_name = gets.chomp
        self.name = user_name
        $name = user_name
        puts "Welcome #{user_name}"
        puts "Single Player? or Two Player?"
        check_input(gets.chomp)
    elsif input == "stats" && !@game_in_session
      @game = Games.all.each {|game| game}
      get_scores
      puts "You can begin playing if you dare..."
      puts "Single Player? or Two Player?"
      check_input(gets.chomp)
    else
      if !@game_in_session
        puts "Invalid Entry"
        puts "Try typing 'single' or 'double' instead"
        #puts "Enter 'help' for help menu"
        invalid_input = gets.chomp.downcase
        check_input(invalid_input)
      elsif input == " "
        self.input = "5"
      end
    end
  end

  def single
    @word = @list_of_words[rand(0..@list_of_words.length - 1)]
    @temp_word = @word.clone
    hang_man
  end

  def double
    p "No peeking, Player 2..."
    p "Player 1, please enter your word:"
    @word = STDIN.noecho(&:gets).chomp.downcase!
    @temp_word = @word.clone
    DisplayMessage.clear
    p "Player 1! You're up!"
    hang_man
  end

  def get_scores
    wins = 0
    losses = 0
    game_data = @game.find_all {|game| game.user1 == $name}
    game_data.map { |user_games| user_games.result ? wins += 1 : losses += 1 }
    puts "Wins : #{wins}"
    puts "Losses : #{losses}"
  end

  def logic
    if @game_in_session
      DisplayMessage.clear
      if @word.include?(@input)
        if @input.length > 1 && @input != @word
          @guesses -= 1
          puts "You have #{self.guesses} guess left" if self.guesses == 1
          puts "You have #{@guesses} guesses left" if self.guesses != 1
          # pictures(@guesses)
          DisplayMessage.pictures(@guesses)
          puts "~~~~~~~~~~~~~~~~~~~~~"
          puts "Remaining Letters: #{remaining_letters}"
          puts "Guessed Letters: #{guessed_letters}"
          puts "Close...but no cigar"
          puts "Try another letter"
          p @blanks_to_fill.join(",")
        elsif @input == @word
          @game_in_session = false
          @game_result = true
          puts "You have #{self.guesses} guess left" if self.guesses == 1
          puts "You have #{@guesses} guesses left" if self.guesses != 1
          DisplayMessage.pictures(self.guesses)
          puts "~~~~~~~~~~~~~~~~~~~~~"
          puts "Remaining Letters: #{remaining_letters}"
          puts "Guessed Letters: #{guessed_letters}"
          puts "~~~~~~~~~~~~~~~~~~~"
          puts "CONGRATS YOU WON!!!"
          puts "~~~~~~~~~~~~~~~~~~~"
        else
          while @temp_word.include?(@input)
            index = @temp_word.index(@input)
            @temp_word[index] = "-"
            @blanks_to_fill[index] = @input
          end
          if self.guessed_letters.include?(self.input)
            puts "You have #{self.guesses} guess left" if self.guesses == 1
            puts "You have #{@guesses} guesses left" if self.guesses != 1
            DisplayMessage.pictures(self.guesses)
            puts "~~~~~~~~~~~~~~~~~~~~~"
            puts "Remaining Letters: #{remaining_letters}"
            puts "Guessed Letters: #{guessed_letters}"
            p "You already used that letter champ."
            p "Enter a new letter"
            p @blanks_to_fill.join(",")
          else
            self.guessed_letters << self.input if @input.length == 1
            self.remaining_letters.delete(self.input)
            puts "You have #{self.guesses} guess left" if self.guesses == 1
            puts "You have #{@guesses} guesses left" if self.guesses != 1
            DisplayMessage.pictures(self.guesses)
            puts "~~~~~~~~~~~~~~~~~~~~~"
            puts "Remaining Letters: #{remaining_letters}"
            puts "Guessed Letters: #{guessed_letters}"
            puts "Nice!!"
            if @blanks_to_fill.include?("_") == false
              @game_in_session = false
              @game_result = true
              puts "~~~~~~~~~~~~~~~~~~~"
              puts "CONGRATS YOU WON!!!"
              puts "~~~~~~~~~~~~~~~~~~~"
            end
            p @blanks_to_fill.join(",")
          end
        end
      elsif input.chars.map {|ch| 96 < ch.ord && ch.ord < 173}.include?(false)
        puts "You have #{self.guesses} guess left" if self.guesses == 1
        puts "You have #{@guesses} guesses left" if self.guesses != 1
        DisplayMessage.pictures(self.guesses)
        p "Invalid Entry"
        p "Your guesses should only include letters"
        puts "Enter a new letter:"
        self.count += 1
        if self.count == 2
          puts "Stop trying to break our code..... Yomi"
          #binding.pry
        elsif self.count == 5 #dealing with spaces
          puts "Really? Still trying to break it????? Try a hammer"
        end
      else
        if @guessed_letters.include?(@input)
          puts "You have #{self.guesses} guess left" if self.guesses == 1
          puts "You have #{@guesses} guesses left" if self.guesses != 1
          DisplayMessage.pictures(self.guesses)
          puts "~~~~~~~~~~~~~~~~~~~~~"
          puts "Remaining Letters: #{remaining_letters}"
          puts "Guessed Letters: #{guessed_letters}"
          p "You already used that letter champ."
          p "Enter a new letter"
          p @blanks_to_fill.join(",")
        else
          @guessed_letters << @input if @input.length == 1
          self.remaining_letters.delete(self.input)
          @guesses -= 1
          if @guesses == 1
            puts "You have #{@guesses} guess left"
            DisplayMessage.pictures(@guesses)
          elsif @guesses == 0
            @game_result = false
            puts "You have #{@guesses} guesses left"
            DisplayMessage.pictures(@guesses)
            puts "Word was : #{self.word}"
          else
            puts "You have #{@guesses} guesses left"
            DisplayMessage.pictures(@guesses)
          end
          if @guesses > 0
            puts "~~~~~~~~~~~~~~~~~~~~~"
            puts "Remaining Letters: #{remaining_letters}"
            puts "Guessed Letters: #{guessed_letters}"
            puts "Try another letter"
            p @blanks_to_fill.join(",")

          end
        end
      end
    end
  end

  def hang_man
    blanks
    DisplayMessage.pictures(self.guesses)
    puts "Guess a single letter or the entire phrase if you dare:"
    p @blanks_to_fill.join(",")

    while @game_in_session == true && @guesses > 0
      input = gets.chomp
      if input == ""
        p "might have pressed enter by accident"
      else
        check_input(input)
        logic
      end
    end
    game = Games.new(self.name)
    game.result = @game_result
    game.user1 = $name
    game.hangman = self
  end
  puts "hello"
end

def blanks
  @blanks_to_fill = @word.split("").map {|ch| ch  == " " ? " " : "_"}
end
