class Deck
  attr_accessor :deck_cards, :bank
  
  TEN_POINTS = 10
  ELEVEN_POINTS = 11

  def initialize
    @deck_cards = []
    @bank = 0
  end

  def get_card
    @deck_cards.pop
  end

  protected

  def full_deck_cards
    (2..10).each do |name|
      %w[♠ ♥ ♦ ♣].each do |suit|
        @deck_cards <<  { name: name.to_s + suit, point: name }
      end
    end

    %w[J Q K A].each do |name|
      %w[♠ ♥ ♦ ♣].each do |suit|
        @deck_cards << { name: name + suit, point: name == 'A' ? @ELEVEN_POINTS : @TEN_POINTS }
      end
    end
    @deck_cards.shuffle!
  end
end
