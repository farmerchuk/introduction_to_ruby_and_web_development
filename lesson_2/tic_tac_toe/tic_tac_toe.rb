class Board
  
  attr_reader :squares
  
  def initialize
    @squares = {}
    build_board
  end
  
  def build_board
    ("1".."9").each { |position| squares[position] = Square.new(Game::EMPTY_MARKER) }
  end
  
  def draw
    system "clear"
    puts " #{squares["1"]} | #{squares["2"]} | #{squares["3"]} "
    puts "-----------"
    puts " #{squares["4"]} | #{squares["5"]} | #{squares["6"]} "
    puts "-----------"
    puts " #{squares["7"]} | #{squares["8"]} | #{squares["9"]} "
  end

  def empty_squares
    squares.select { |_, square| square.marker == Game::EMPTY_MARKER }
  end

  def empty_positions
    empty_squares.keys
  end

  def full?
    empty_positions.size == 0
  end

  def place_marker(position, player)
    squares[position] = Square.new(player.marker)
  end

end

class Square
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
  
  def to_s
    marker
  end
  
end

class Player
  attr_reader :name, :marker
  
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
  
  def to_s
    name
  end
  
end


class Game
  WINNING_LINES = [["1", "2", "3"],["4", "5", "6"],["7", "8", "9"],
                   ["1", "4", "7"],["2", "5", "8"],["3", "6", "9"],
                   ["1", "5", "9"],["3", "5", "7"]]
  X_MARKER = "X"
  O_MARKER = "O"
  EMPTY_MARKER = " "
  
  attr_reader :human, :computer, :board
  attr_accessor :current_player, :not_current_player
  
  def initialize
    @human = Player.new("Jason", X_MARKER)
    @computer = Player.new("C3PO", O_MARKER)
    @board = Board.new
    @current_player = human
    @not_current_player = computer
  end

  def player_places_marker
    if current_player == human
      begin
        puts "You may select from squares: #{board.empty_positions}"
        print "Which square would you like: "
        player_choice = gets.chomp
      end until board.empty_positions.include?(player_choice)   
      board.place_marker(player_choice, current_player)
    else
      computer_choice
    end
  end

  def computer_choice
    if best_position
      board.place_marker(best_position, current_player)
    else
      board.place_marker(board.empty_positions.sample, current_player)
    end
  end

  def best_position
    WINNING_LINES.each do |line|
      line_squares = {}
      board.squares.each do |position, square|
        line_squares[position] = square.marker if line.include?(position)
      end
      if line_squares.values.count(current_player.marker) == 2      
        line_squares.each { |position, marker| return position if marker == EMPTY_MARKER }
      end
      if line_squares.values.count(not_current_player.marker) == 2      
        line_squares.each { |position, marker| return position if marker == EMPTY_MARKER }
      end
    end
    nil
  end

  def alternate_player
    this_current_player = current_player
    self.current_player = not_current_player
    self.not_current_player = this_current_player
  end

  def three_in_row?
    WINNING_LINES.each do |line|
      if board.squares[line[0]].marker == current_player.marker &&
         board.squares[line[1]].marker == current_player.marker &&
         board.squares[line[2]].marker == current_player.marker
        return true
      end
    end
    false
  end
  
  def play
    loop do
      board.draw
      player_places_marker
      if three_in_row?
        board.draw
        puts "#{current_player} wins the game!"
        break
      elsif board.full?
        board.draw
        puts "It's a tie!"
        break
      end
      alternate_player
    end
  end

end

Game.new.play
