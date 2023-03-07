require_relative "player"

class Diler < Player
  def initialize
    super("Diler")
  end

  def move_action(game)
    take_card = false

    points = 0
    self.hend.each {|i| points += i[1]}

    case points
      when < 10
        take_card = true
      when < 12
        take_card = rand < 0.9
      when < 14
        take_card = rand < 0.45
      when < 17
        take_card = rand < 0.1
    end

    take_card && self.hend.count < 2 ? self.add_card(game.get_card)
  end
end
