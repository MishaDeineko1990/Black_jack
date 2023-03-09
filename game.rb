require_relative 'black_jeck_core'
require_relative 'player'
require_relative 'diler'

class Game < BlackJeckCore
  attr_reader :player, :diler
  attr_accessor :move_players

  def initialize
    super
    puts 'Enter your name:'
    player_name = gets.chomp
    @player = Player.new(player_name)
    @diler = Diler.new
    @decision_finish_raund = {@diler => false, @player => false}
    @count_pass = 0
  end

  def start_round
    full_deck_cards
    2.times { @player.add_card(get_card) }
    2.times { @diler.add_card(get_card) }
    @bank = 20
    @player.send_money(10)
    @diler.send_money(10)
  end

  def show_cards(hide_diler_cards)
    puts "#{@diler.name} cards on hand: #{cards_on_hand(@diler.hend, @diler.name == 'Diler' ? hide_diler_cards : false)}"
    puts "#{@player.name} cards on hand: #{cards_on_hand(@player.hend)}"
  end
  
  def cards_on_hand(cards, close_card = false)
    s_out = ""
    point_counts = 0

    if close_card
      s_out = "[*] " * cards.count
    else
      cards.each do |i|
        s_out += "[#{i[0]}] "
        point_counts += i[1]
      end
      "#{s_out}#{point_counts}" 
    end
  end

  def make_move(player)
    return player.move_action(self) if player.name == 'Diler'

    loop do
      puts ''
      puts 'You step!!!'
      puts '-----------------------'
      puts 'Write 1 to open cards'
      puts 'Write 2 to take card' if player.hend.count < 3
      puts 'Write 3 to pass' if player.hend.count < 3 || @count_pass < 1
      choice = gets.chomp

      case choice
      when '1'
        @decision_finish_raund[player] = true
        break
      when '2'
        player.add_card(get_card)
        break
      when '3'
        @count_pass = 1
        break
      else
        puts 'Invalid input. Please try again.'
      end
    end
  end

  def finish_raund?

  end

  def finish_raund

  end

  def finish_game?

  end

  # додати рышення закынчити раунд
end
