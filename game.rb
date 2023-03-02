



# puts @cards[51]

class Game
  attr_reader :deck_cards
  def initialize
    @deck_cards = []
    full_deck_cards()
  end

  def get_card
    card = @deck_cards.sample
    @deck_cards.delete(card)
    card
  end

  private 
  def full_deck_cards
    (2..10).each do |i|
      %w[♠ ♥ ♦ ♣].each do |i2|
        @deck_cards << [i.to_s + i2 , i]
      end
    end

    %w[J Q K A].each do |i|
      %w[♠ ♥ ♦ ♣].each do |i2|
          @deck_cards << [i + i2 , i == "A" ? 11 : 10]
      end
    end
  end
end

class Player
  attr_reader: hend
  attr_reader: purse

  def add_card

  end

  def fold

  end
end


a = Game.new

b = a.get_card()

puts b
puts a.deck_cards.inspect
