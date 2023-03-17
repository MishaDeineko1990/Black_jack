require_relative "player"

class Dealer < Player
  def initialize
    super("dealer")
  end

  def move_action(game)
    return if game.decision_finish_raund_dealer

    take_card = false

    @points = 0

    game.dealer.hend.each {|i| @points += i[1]}

    case @points
    when 0..9
      take_card = true
    when 10..11
      take_card = rand < 0.9
    when 12..13
      take_card = rand < 0.45
    when 14..16
      take_card = rand < 0.2
    end

    take_card && self.hend.count < 3 ? self.add_card(game.get_card) : nil
    game.decision_finish_raund_dealer = true
  end
end
