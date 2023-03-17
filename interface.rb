require_relative "game"

class Interface

  def initialize
    @game = Game.new
    black_jack()
  end
  
  def black_jack
    black_jack!()
  end

  private 
  def black_jack!  
    puts "Game is start"
    i = 1
    loop do
      @game.start_round()
      puts "Raund #{i}"
      @game.finish_raund() if @game.finish_raund?      
      @game.show_cards(true)
      @game.make_move(@game.player)
      @game.make_move(@game.dealer)
      i += 1
      @game.finish_raund() if @game.finish_raund?      
    end
  end
end
