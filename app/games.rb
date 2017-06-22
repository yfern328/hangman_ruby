class Games

  attr_accessor :user1, :user2, :result, :hangman

  @@all = []

  def initialize(user1="User 1", user2="Computer")
    #@hangman = Hangman.new
    @user1 = user1
    @user2 = user2
    @@all << self
  end

  def self.all
    @@all
  end

end
