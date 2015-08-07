class Player
  include Comparable
  attr_reader :name
  attr_accessor :choice
  
  def initialize(name)
    @name = name
    @choice
  end
  
  def <=>(another_player)
    return 1 if choice == "r" && another_player.choice == "s"
    return 1 if choice == "p" && another_player.choice == "r"
    return 1 if choice == "s" && another_player.choice == "p"
    return 0 if choice == another_player.choice
    return -1
  end
  
  def select_choice
    while !Game::CHOICES.keys.include?(choice)
      print "Choose Rock(r), Paper(p) or Scissors(s): "
      self.choice = gets.chomp
    end
  end
  
end

class Human < Player
end

class Computer < Player
  def select_choice
    self.choice = Game::CHOICES.keys.sample
  end
end

class Game
  CHOICES = {"r" => "ROCK", "p" => "PAPER", "s" => "SCISSORS"}
  
  attr_accessor :human, :computer
  
  def initialize
    @human = Human.new("Jason")
    @computer = Computer.new("C3PO")
  end
  
  def play
    welcome_message
    loop do
      human.select_choice
      computer.select_choice
      declare_winner
      exit if !play_again?
    end
  end
  
  def welcome_message
    puts "Welcome #{human.name}," 
    puts "Today you will be battling #{computer.name} for supremecy in Rock, Paper, Scissors!"
  end
  
  def declare_winner
    if human > computer
      puts "You win! #{CHOICES[human.choice]} beats #{CHOICES[computer.choice]}!"
    elsif human < computer
      puts "You lose! #{CHOICES[computer.choice]} beats #{CHOICES[human.choice]}!"
    else
      puts "It's a tie! You both chose #{CHOICES[human.choice]}!"
    end
  end

  def play_again?
    begin
      print "Would you like to play again? "
      response = gets.chomp
    end until ["y", "n"].include?(response)
    human.choice = nil
    return true if response == "y"
    false
  end
  
end

Game.new.play