require_relative 'player'

class Dealer < Player
  MAX_COUNT_CARDS = 3

  def initialize
    super('dealer')
  end

  def decide_dealer_move(game) #simulation of the dealer's decision to take a card.
    return if game.decision_finish_raund_dealer

    take_card = false

    points = game.dealer.count_points

    case points #simulate dealer decides take card
    when 0..9
      take_card = true
    when 10..11
      take_card = rand < 0.9 #return true from probability 90%
    when 12..13
      take_card = rand < 0.45
    when 14..16
      take_card = rand < 0.2
    end

    take_card && hend.count < MAX_COUNT_CARDS ? add_card(game.get_card) : nil # If the player decides to take a card, add the card to the dealer's hand
    game.decision_finish_raund_dealer = true
  end
end
