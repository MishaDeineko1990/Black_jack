require_relative "game"

class Interface

  def initialize
    @game = Game.new
    @game.start_round()
    select_do()
  end
  
  def select_do
    select_do!()
  end

  private 
  def select_do!  
    loop do
      puts "Game is start"
      @game.show_cards(true)
      @game.make_move(@game.player)
      @game.make_move(@game.diler)      
    end
  end
end
