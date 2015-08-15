# blackjack.rb
require "pry"

class Card
  attr_reader :suit, :face_value
  
  def initialize(suit, face_value)
    @suit = suit
    @face_value = face_value
  end
  
  def to_s
    "#{face_value} of #{suit}"
  end
  
end

class Deck
  attr_accessor :cards
  
  SUITS = %w(HEARTS DIAMONDS CLUBS SPADES)
  FACE_VALUES = %w(2 3 4 5 6 7 8 9 10 JACK QUEEN KING ACE)
  
  def initialize(num_of_decks)
    @cards = []
    num_of_decks.times { build_deck }
    shuffle!
  end
  
  def build_deck
    SUITS.each do |suit|
      FACE_VALUES.each do |face_value|
        cards << Card.new(suit, face_value)
      end
    end
  end
  
  def shuffle!
    4.times { cards.shuffle! }
  end
  
  def deal_card
    cards.pop
  end

end

class Player
  attr_accessor :name, :hand
  
  def initialize(name)
    @name = name
    @hand = Hand.new
  end
  
end

class Hand
  attr_accessor :cards
  
  def initialize
    @cards = []
  end
  
  def add_card(card)
    cards << card
  end
  
  def value
    hand_value = 0
    aces = 0
    cards.each do |card|
      aces += 1 if card.face_value == "ACE"
      hand_value += 11 if card.face_value == "ACE"
      hand_value += 10 if card.face_value.to_i == 0 && card.face_value != "ACE"
      hand_value += card.face_value.to_i if card.face_value.to_i != 0
      aces.times { hand_value -= 10 if hand_value > 21 }
    end
    hand_value
  end
  
end

class Game
  attr_accessor :guest, :dealer, :deck
  
  BLACKJACK = 21
  DEALER_STAY_MIN = 17
  
  def initialize
    @guest = Player.new("Jason")
    @dealer = Player.new("Dealer")
    @deck = Deck.new(3)
  end
  
  def play
    system "clear"
    get_player_name(guest)
    begin
      system "clear"   
      deal_initial_hands(guest, dealer)
      display_player_hand(guest)
      display_dealer_top_card
      player_turn(guest)
      dealer_turn
    end until !play_again?
  end
  
  def display_player_hand(player)
    puts "#{player.name}, your hand value is: #{player.hand.value}"
    puts
    puts "The cards you hold are:"
    puts player.hand.cards
    puts
  end
  
  def display_dealer_top_card
    puts "The dealer is holding the #{dealer.hand.cards.first}"
    puts
  end
  
  def display_dealer_hand
    puts "The dealer's hand value is: #{dealer.hand.value}"
    puts
    puts "Her cards are:"
    puts dealer.hand.cards
    puts
  end
  
  def display_flop(player)
    system "clear"
    display_player_hand(player)
    display_dealer_top_card
  end
  
  def display_all_cards(player)
    system "clear"
    display_player_hand(player)
    display_dealer_hand
  end
  
  def get_player_name(player)
    puts "Welcome to Blackjack!"
    puts "*********************"
    puts
    print "Please enter your name: "
    player.name = gets.chomp
  end
  
  def deal_initial_hands(player1, player2)
    2.times { player1.hand.add_card(deck.deal_card) }
    2.times { player2.hand.add_card(deck.deal_card) }   
  end
  
  def hit?
    begin
      print "Would you like to HIT or STAND? "
      player_choice = gets.chomp.downcase 
    end until ['hit', 'stand'].include?(player_choice)
    player_choice == "hit" ? true : false
  end
  
  def deal_card(player)
    player.hand.add_card(deck.deal_card)
  end

  def bust?(player)
    player.hand.value > BLACKJACK
  end

  def blackjack?(player)
    player.hand.value == BLACKJACK
  end

  def winning_hand(player)
    display_all_cards(player)
    if player.hand.value > dealer.hand.value
      puts "#{player.name} has the best hand and wins!"
    else
      puts "Dealer has the best hand. You lose!"
    end
  end

  def tie?(player1, player2)
    player1.hand.value == player2.hand.value
  end

  def player_turn(player)
    if blackjack?(player)
      puts "#{player.name} gets Blackjack and wins!"
      play_again?
    end
    loop do
      display_flop(player)
      if bust?(player)
        display_all_cards(player)
        puts "#{player.name} busts and loses! Dealer wins!"
        play_again?
      elsif blackjack?(player)
        display_all_cards(player) 
        puts "#{player.name} hits Blackjack and wins!"       
        play_again?
      end
      hit? ? deal_card(player) : break
    end
  end
  
  def dealer_turn
    while dealer.hand.value < DEALER_STAY_MIN
      deal_card(dealer)
    end
    display_all_cards(guest)
    if bust?(dealer)      
      puts "Dealer busts and loses! #{guest.name} wins!"
    elsif blackjack?(dealer)
      puts "Dealer hits Blackjack and wins! You lose!"       
    elsif tie?(guest, dealer)
      puts "It's a tie!"
    else
      winning_hand(guest)
    end
  end

def play_again?
  puts
  print "Would you like to play again? (YES/NO): "
  player_choice = gets.chomp.downcase
  if player_choice == "yes"
    guest.hand.cards.clear
    dealer.hand.cards.clear
    self.deck = Deck.new(3)
    play
  else
    puts
    puts "Thank you for playing!"
    exit
  end
end

end

Game.new.play