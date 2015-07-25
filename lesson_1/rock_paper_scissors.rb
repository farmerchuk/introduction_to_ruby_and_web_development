# rock_paper_scissors.rb

# declare variables
CHOICES = { "r" => "ROCK", "p" => "PAPER", "s" => "SCISSORS" }
player_choice = ""
computer_choice = ""

# welcome message
puts "Rock, Paper, Scissors: The Game!"
puts "################################"
puts

# game loop
loop do
  
  # get player's choice
  begin
    print "Enter (r) for ROCK, (p) for PAPER or (s) for SCISSORS: "
    player_choice = gets.chomp.downcase
    if !CHOICES.keys.include?(player_choice)
      puts "That is not a valid option. Choose again please."
      puts
    end
  end until CHOICES.keys.include?(player_choice)

  # get computer's choice
  computer_choice = CHOICES.keys.sample

  # determine winner
  if player_choice == computer_choice
    puts "You both chose #{CHOICES[player_choice]}. It's a tie!"
  elsif player_choice == "r" && computer_choice == "s"
    puts "You win! The computer chose #{CHOICES[computer_choice]}."
  elsif player_choice == "p" && computer_choice == "r"
    puts "You win! The computer chose #{CHOICES[computer_choice]}."
  elsif player_choice == "s" && computer_choice == "p"
    puts "You win! The computer chose #{CHOICES[computer_choice]}."
  else
    puts "Womp womp... you lose :( The computer chose #{CHOICES[computer_choice]}."
  end

  # ask to reply
  puts  
  print "Would you like to play again? (y/n): "
  if gets.chomp.downcase != "y" 
    puts
    puts "Thank you for playing!"
    break
  end
  puts

end
