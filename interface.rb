require_relative "game"

class Interface

  def initialize
    @game = Game.new
    @game.raund_start()
    select_do()
  end
  
  def select_do
    select_do!()
  end

  private 
  def select_do!  
    loop do
      puts "Game is start"
      @game.show_card(true, false)
      @game.make_move(@game.player)
      @game.make_move(@game.diler)# write code for diler
      a = gets.chomp
    end
  end
end
