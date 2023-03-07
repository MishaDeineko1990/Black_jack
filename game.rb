require_relative "black_jeck_core"
require_relative "player"
require_relative "diler"

class Game < Black_jeck_core
  attr_reader :player, :diler
  attr_accessor :move_plaers
  
  def initialize
    super
    puts "Write name"
    paler_name = gets.chomp
    @player = Player.new(paler_name)
    @diler = Diler.new()
    @move_plaers =  {@diler => false, @player => false}
  end
  
  def raund_start
    full_deck_cards()
    @player.add_card(get_card())
    @player.add_card(get_card())
    @diler.add_card(get_card())
    @diler.add_card(get_card())
    @bank = 20
    @player.send_money(10)
    @diler.send_money(10)
  end

  def show_card(p1, p2)
    puts_card(@diler, p1)
    puts_card(@player, p2)
  end

  def puts_card(player, close_card = true)
    sum = 0
    player.hend.each {|i| sum += i[1]}
    puts "#{player.name} card on hend #{close_card ? "[*]" * player.hend.count: player.hend.inspect } = #{close_card ? "*" : sum}"
  end

  def make_move(player)
    puts ""
    puts "Write 1 if want open cards" 
    puts "Write 2 if want take card" if player.hend.count < 3
    puts "Write 3 if want make to pass" if player.hend.count < 3 || @move_plaers[player] == 3
    choose_action = player.name == "Diler" ? player.move_action(self) : gets.chomp
    case choose_action
      when '1'
        @move_plaers[player] = 3
      when '2'
        player.add_card(get_card())        
    end
  
  end
end
