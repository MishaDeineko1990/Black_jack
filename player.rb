class Player
  attr_reader :name, :wallet
  attr_accessor :hend

  def initialize(name)
    @name = name
    @wallet = 100
    @hend = []
    @MAX_COUNT_CARDS ||= 3
  end

  def count_points
    points = @hend.sum { |card| card[:point] }
  end

  def clean_hend
    @hend = []
  end

  def add_card(card)
    @hend << card
  end

  def send_money(count)
    @wallet -= count
  end

  def get_money(count)
    @wallet += count
  end
end
