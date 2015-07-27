# tic_tac_toe.rb

# pseudo code
##########################################################

# 1. draw the board
# 2. decide who goes first, player or computer
# 3. first player chooses an empty square
# 4. check to see if there is a winner
# 5. second player chooses and empty square
# 6. check to see if there is a winner
# 7. repeat until there is a winner or all the squares are filled, in the case of a tie

# declare variables
##########################################################

WINNING_LINES = [["1", "2", "3"],["4", "5", "6"],["7", "8", "9"],["1", "4", "7"],["2", "5", "8"],["3", "6", "9"],["1", "5", "9"],["3", "5", "7"]]
board = {}
first_player = ""

# methods
##########################################################
def initialize_board(board)
  ("1".."9").each { |square| board[square] = " " }
  board
end

def draw_board(board)
  system "clear"
  puts "Tic-Tac-Toe"
  puts "###########"
  puts
  puts " #{board["1"]} | #{board["2"]} | #{board["3"]} "
  puts "-----------"
  puts " #{board["4"]} | #{board["5"]} | #{board["6"]} "
  puts "-----------"
  puts " #{board["7"]} | #{board["8"]} | #{board["9"]} "
  puts
end

def determine_first_player
  ["Human", "Computer"].sample
end

def player_selects_empty_square(board)
  empty_squares = board.select { |k,v| v == " " }.keys
  begin
    puts "You may select from square(s): #{empty_squares.to_s}."
    print "What is your choice? "
    player_choice = gets.chomp
  end until empty_squares.include?(player_choice)
  board[player_choice] = "X"
  draw_board(board)
end

def computer_selects_empty_square(board)
  best_square = test_for_two_in_a_row(board)
  if best_square
    board[best_square] = "O"
  else
    computer_choice = board.select { |k,v| v == " " }.keys.sample
    board[computer_choice] = "O"
  end
  draw_board(board)
end

def test_for_two_in_a_row(board)
  best_choice = nil
  WINNING_LINES.each do |winning_line|
    if board.values_at(*winning_line).count("X") == 2
      winning_line.each do |value|
        if board[value] == " "
          best_choice = value
        end
      end
    end
  end
  WINNING_LINES.each do |winning_line|
    if board.values_at(*winning_line).count("O") == 2
      winning_line.each do |value|
        if board[value] == " "
          best_choice = value
        end
      end
    end
  end
  best_choice
end

def return_winner(board)
  WINNING_LINES.each do |winning_line|
    if board[winning_line[0]] == "X" && board[winning_line[1]] == "X" && board[winning_line[2]] == "X"
      return "X"
    elsif board[winning_line[0]] == "O" && board[winning_line[1]] == "O" && board[winning_line[2]] == "O"
      return "O"
    end
  end
  if !board.values.include?(" ")
    return "T"
  end
end

def print_winner(board)
  if return_winner(board) == "X"
    puts "X wins!"
    return true
  elsif return_winner(board) == "O"
    puts "O wins!"
    return true
  elsif return_winner(board) == "T"
    puts "It's a tie!"
    return true
  end
  false
end

# gameplay
##########################################################

first_player = determine_first_player
initialize_board(board)
draw_board(board)

if first_player == "Human"
  loop do
    player_selects_empty_square(board)
    if print_winner(board)
      break
    end
    computer_selects_empty_square(board)
    if print_winner(board)
      break
    end
  end
else
  loop do
    computer_selects_empty_square(board)
    if print_winner(board)
      break
    end
    player_selects_empty_square(board)
    if print_winner(board)
      break
    end
  end
end








