# constants

CARD_SUITS = [ "HEARTS", "CLUBS", "DIAMONDS", "SPADES" ]
CARD_TYPES = { "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, 
               "7" => 7, "8" => 8, "9" => 9, "10" => 10, "JACK" => 10, 
               "QUEEN" => 10, "KING" => 10, "ACE" => 11 }

# variables

player_name = ""
dealer_name = "Dealer"
deck = []
player_hand = []
dealer_hand = []

# methods

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

def deal_card(deck, hand)
  hand << deck.pop
end

def calculate_hand_value(hand)
  return 0 if hand.empty?
  hand_value = 0
  hand.each { |card| hand_value += card[:value] }
  return hand_value
end

def display_hand_value(hand)
  puts "Your hand value is: #{calculate_hand_value(hand)}"
end

def display_top_card(player, hand)
  puts "#{player}'s hand shows: #{hand[0][:name]} of #{hand[0][:suit]}"
end
  
def display_hand(player, hand)
  puts "#{player}, your hand includes:"
  hand.each { |card| puts "#{card[:name]} of #{card[:suit]}"}
end

def hit?
  begin
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

def play_dealer(deck, dealer_hand)
  loop do
    if is_bust?(dealer_hand)
      return "bust"
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
    print "Select [1] to PLAY AGAIN or [2] to QUIT: "
    player_input = gets.chomp
    return true if player_input == "1"
  end until player_input == "1" || player_input == "2"
end

# gameplay

get_name(player_name)

initialize_deck(deck)
2.times { deal_card(deck, player_hand) }
2.times { deal_card(deck, dealer_hand) }

# player turn

loop do
  display_top_card(dealer_name, dealer_hand)
  display_hand(player_name, player_hand)
  display_hand_value(player_hand)  
  if is_bust?(player_hand)
    puts "Sorry, you bust!"
    break
  elsif is_blackjack?(player_hand)
    puts "Blackjack, you win!"
    break
  end
  if hit?
    deal_card(deck, player_hand)
  else
    puts play_dealer(deck, dealer_hand)  
    break
  end
end










