require_relative 'game'

class Interface
  def initialize
  end
  
  def black_jack
    puts 'Enter your name:'
    player_name = gets.chomp
    @game = Game.new(player_name)
    puts 'Game is start'
    loop do
      puts '-------------------------'
      puts 'Start new raund'
      @game.start_round
      @game.finish_raund if @game.finish_raund?
      @game.show_cards(true)
      @game.make_move(@game.player)
      @game.make_move(@game.dealer)
      @game.finish_raund if @game.finish_raund?
    end
  end
end
