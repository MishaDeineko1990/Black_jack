class BlackJeckCore
  attr_accessor :deck_cards, :bank

  def initialize
    @deck_cards = []
    @bank = 0
  end

  def get_card # //core
    card = @deck_cards.sample
    @deck_cards.delete(card)
    card
  end

  protected

  def full_deck_cards
    (2..10).each do |i|
      %w[♠ ♥ ♦ ♣].each do |i2|
        @deck_cards << [i.to_s + i2, i]
      end
    end

    %w[J Q K A].each do |i|
      %w[♠ ♥ ♦ ♣].each do |i2|
        @deck_cards << [i + i2, i == 'A' ? 11 : 10]
      end
    end
  end
end
