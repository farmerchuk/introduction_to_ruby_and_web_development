# constants

CARD_SUITS = [ "HEARTS", "CLUBS", "DIAMONDS", "SPADES" ]
CARD_TYPES = { "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, 
               "7" => 7, "8" => 8, "9" => 9, "10" => 10, "JACK" => 10, 
               "QUEEN" => 10, "KING" => 10, "ACE" => 11 }

# variables

player_name = ""
deck = []
player_hand = []
dealer_hand = []

# methods

def output(string)
  puts "  " + string
end

def header_message(string)
  puts
  puts "**************************"
  puts "* " + string.center(22) + " *"
  puts "**************************"
  puts
end

def get_name(player)
  begin
    print "What is your name? "
    player.replace(gets.chomp)
  end until !player.empty? 
end

def initialize_deck(deck)
  4.times do
    CARD_SUITS.each do |suit|
      CARD_TYPES.each { |k, v| deck << { suit: suit, name: k, value: v } }
    end
  end
  10.times { deck.shuffle!}
end

def reset_hands(hand1, hand2)
  hand1.clear
  hand2.clear
end

def deal_card(deck, hand)
  hand << deck.pop
end

def calculate_hand_value(hand)
  return 0 if hand.empty?
  hand_value = 0
  number_of_aces = count_aces(hand)
  hand.each { |card| hand_value += card[:value] }
  loop do
    if hand_value > 21 && number_of_aces > 0
      hand_value -= 10
      number_of_aces -= 1
    else
      break
    end
  end
  return hand_value
end

def count_aces(hand)
  number_of_aces = 0
  hand.each do |card| 
    if card[:name] == "ACE"
      number_of_aces += 1
    end
  end
  number_of_aces
end

def display_hand_value(hand)
  puts "The hand value is: #{calculate_hand_value(hand)}"
end

def display_top_card(hand)
  puts "Dealer's hand shows:"
  output "#{hand[0][:name]} of #{hand[0][:suit]}"
  puts
end
  
def display_player_hand(hand, player_name)
  puts "#{player_name}, your hand includes:"
  hand.each { |card| output "#{card[:name]} of #{card[:suit]}"}
  display_hand_value(hand)
end

def display_dealer_hand(hand)
  puts "Dealer's hand includes:"
  hand.each { |card| output "#{card[:name]} of #{card[:suit]}"}
  display_hand_value(hand)
end

def hit?
  begin
    puts
    print "Select [1] to HIT or [2] to STAND: "
    player_input = gets.chomp
    return true if player_input == "1"
  end until player_input == "1" || player_input == "2"
end

def is_blackjack?(hand)
  return true if calculate_hand_value(hand) == 21
end

def is_bust?(hand)
  return true if calculate_hand_value(hand) > 21
end

def is_atleast_17(hand)
  return true if calculate_hand_value(hand) >= 17
end

def is_tie?(hand1, hand2)
  return true if calculate_hand_value(hand1) == calculate_hand_value(hand2)
end

def dealer_turn(deck, dealer_hand)
  loop do
    if is_bust?(dealer_hand)
      return "BUST"
    end
    if !is_atleast_17(dealer_hand)
      deal_card(deck, dealer_hand)
    else
      return calculate_hand_value(dealer_hand)
    end
  end
end

def play_again?
  begin
    puts
    print "Select [1] to PLAY AGAIN or [2] to QUIT: "
    player_input = gets.chomp
    if player_input == "1"
      return true
    end
  end until player_input == "1" || player_input == "2"
end

# gameplay

system "clear"
header_message "BLACKJACK!"
get_name(player_name)

begin
  initialize_deck(deck)
  reset_hands(player_hand, dealer_hand)
  2.times { deal_card(deck, player_hand) }
  2.times { deal_card(deck, dealer_hand) }

  loop do
    system "clear"
    display_top_card(dealer_hand)
    display_player_hand(player_hand, player_name)

    if is_bust?(player_hand)
      header_message "YOU BUST. DEALER WINS!"
      break
    elsif is_blackjack?(player_hand)
      header_message "BLACKJACK, YOU WIN!"
      break
    end
    
    if hit?
      deal_card(deck, player_hand)
    else
      dealer_turn_result = dealer_turn(deck, dealer_hand)
      if dealer_turn_result == "BUST"
        header_message "DEALER BUSTS, YOU WIN!"
        display_dealer_hand(dealer_hand)    
      elsif is_tie?(player_hand, dealer_hand)
        header_message "IT'S A TIE!"
        display_dealer_hand(dealer_hand)
      else
        if calculate_hand_value(player_hand) > calculate_hand_value(dealer_hand)
          header_message "YOU WIN!"
          display_dealer_hand(dealer_hand)
        else
          header_message "DEALER WINS!"
          display_dealer_hand(dealer_hand)
        end
      end
      break
    end
    
  end
end until !play_again?

header_message "Thank you for playing!"
exit








