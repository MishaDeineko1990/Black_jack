require_relative 'black_jeck_core'
require_relative 'player'
require_relative 'diler'

class Game < BlackJeckCore
  attr_reader :player, :diler
  attr_accessor :move_players, :decision_finish_raund_diler

  def initialize
    super
    puts 'Enter your name:'
    player_name = gets.chomp
    @player = Player.new(player_name)
    @diler = Diler.new
    @decision_finish_raund_diler =  false
    @decision_finish_raund_player =  false
    @count_pass = 0

  end

  def start_round
    full_deck_cards()
    @player.clean_hend
    @diler.clean_hend
    2.times { @player.add_card(get_card) }
    2.times { @diler.add_card(get_card) }
    @player.send_money(10)
    @diler.send_money(10)
    @bank = 20
  end

  def show_cards(hide_diler_cards)
    puts "#{@diler.name} cards on hand: #{cards_on_hand(@diler.hend, hide_diler_cards)}"
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
   
    puts ''
    puts 'You step!!!'
    puts '-----------------------'
    puts 'Write 1 to open cards'
    puts 'Write 2 to take card' if player.hend.count < 3
    puts 'Write 3 to pass' if player.hend.count < 3 || @count_pass != 1
    choice = gets.chomp

    case choice
    when '1'
      @decision_finish_raund_player = true
      return
    when '2'
      player.add_card(get_card)
      @decision_finish_raund_player = true
      return
    when '3'
      @count_pass = 1
      return
    else
      puts 'Invalid input. Please try again.'
    end
    
  end

  def finish_raund?
    return true if @player.hend.count == 3 && @diler.hend.count == 3
    return true if @decision_finish_raund_diler && @decision_finish_raund_player     
    return true if @player.count_pionts > 21
    return false
  end

  def finish_raund()
    @decision_finish_raund_diler = false
    @decision_finish_raund_player = false
    show_cards(false)
    case winner()
    when 'draw'
      @player.get_money(@bank / 2)
      @diler.get_money(@bank / 2)
    when @player
      @player.get_money(@bank) 
    else
      @diler.get_money(@bank) 
    end

    output_resault() 

    @bank = 0    
    @deck_cards = []
    @player.hend = []
    @diler.hend = []

    bb = gets
  end

  def winner
    if @player.count_pionts > 21 && @diler.count_pionts > 21
      if @diler.count_pionts > @player.count_pionts 
        return @diler
      else
        return @player
      end
    elsif @player.count_pionts == @diler.count_pionts
      return 'draw'
    elsif @player.count_pionts < 21 && @diler.count_pionts > 21
      return @player
    elsif 21 - @player.count_pionts < 21 - @diler.count_pionts
      return @player
    else
      return @diler
    end
  end

  def output_resault()
    
    case winner()
    when 'draw'
      puts '-----------Draw-------------'
      wallet_plaers()      
    when @player
      puts '-----------YOU WINN-------------'
      wallet_plaers() 
    else
      puts '-----------Diler win-------------'
      wallet_plaers()
    end
  end

  def wallet_plaers
    puts "#{@diler.name} have on wallet #{@diler.wallet}$"    
    puts "#{@player.name} have on wallet #{@player.wallet}$"
    puts '----------------------------'
  end

  # додати рышення закынчити раунд
end
