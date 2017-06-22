class User

  attr_accessor :name, :games

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end
end

#user1 = User.new("user1")
