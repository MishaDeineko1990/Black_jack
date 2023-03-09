class Player
  attr_reader :name, :hend, :wallet
  
  def initialize(name)
    @name = name
    @wallet = 100
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