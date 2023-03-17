require_relative 'black_jeck_core'
require_relative 'player'
require_relative 'dealer'

class Game < BlackJeckCore
  attr_reader :player, :dealer
  attr_accessor :move_players, :decision_finish_raund_dealer

  def initialize
    super
    puts "1f"
    puts 'Enter your name:'
    player_name = gets.chomp
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @decision_finish_raund_dealer =  false
    @decision_finish_raund_player =  false
    @count_pass = 0

  end

  def start_round
    puts "start raund"
    puts "2f"
    
    full_deck_cards()
    @player.clean_hend
    @dealer.clean_hend
    2.times { @player.add_card(get_card) }
    2.times { @dealer.add_card(get_card) }
    @player.send_money(10)
    @dealer.send_money(10)
    @bank = 20
  end

  def show_cards(hide_dealer_cards)
    puts "3f"

    puts "#{@dealer.name} cards on hand: #{cards_on_hand(@dealer.hend, hide_dealer_cards)}"
    puts "#{@player.name} cards on hand: #{cards_on_hand(@player.hend)}"
  end
  
  def cards_on_hand(cards, close_card = false)
    puts "4f"
    
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
    puts "5f"

    return player.move_action(self) if player.name == 'dealer'
    puts "5.1f"
   
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
    puts "6f"

    return true if @player.hend.count == 3 && @dealer.hend.count == 3
    return true if @decision_finish_raund_dealer && @decision_finish_raund_player     
    return true if @player.count_pionts > 21
    return false
  end

  def finish_raund()
    puts "7f"

    @decision_finish_raund_dealer = false
    @decision_finish_raund_player = false
    show_cards(false)
    case winner()
    when 'draw'
      @player.get_money(@bank / 2)
      @dealer.get_money(@bank / 2)
    when @player
      @player.get_money(@bank) 
    else
      @dealer.get_money(@bank) 
    end

    output_resault() 

    @bank = 0    
    @deck_cards = []
    @player.hend = []
    @dealer.hend = []

    exit_game() if @dealer.wallet < 10 || @player.wallet < 10
    puts 'Enter "end" if you want to finish the game if not enter enything.'    
    finish_game = gets.chomp.downcase!
    exit_game() if finish_raund == 'end' 
  end

  def winner
    puts "8f"

    if @player.count_pionts > 21 && @dealer.count_pionts > 21
      if @dealer.count_pionts > @player.count_pionts 
        return @dealer
      else
        return @player
      end
    elsif @player.count_pionts == @dealer.count_pionts
      return 'draw'
    elsif @player.count_pionts < 21 && @dealer.count_pionts > 21
      return @player
    elsif 21 - @player.count_pionts < 21 - @dealer.count_pionts
      return @player
    else
      return @dealer
    end
  end

  def winner(player_points = @player.count_pionts, dealer_points = @dealer.count_pionts)
    puts "9f"

    if player_points > 21 || dealer_points > 21
      return @dealer if player_points < dealer_points
      return @player if player_points > dealer_points    
    elsif player_points > 21
      return @dealer
    elsif dealer_points > 21
      return @player
    elsif player_points == dealer_points
      return 'draw'
    elsif player_points > dealer_points
      return @player
    else
      return @dealer
    end
  end

  def output_resault()
    puts "10f"

    result = {
      'draw' => '-----------Draw-------------',
      @player => '-----------YOU WIN-------------',
      !@player => '-----------Dealer wins----------'
    }[winner()]

    puts result
    wallet_plaers()
  end

  def wallet_plaers
    puts "11f"

    puts "#{@dealer.name} have on wallet #{@dealer.wallet}$"    
    puts "#{@player.name} have on wallet #{@player.wallet}$"
    puts '----------------------------'
  end

  def exit_game()
    puts "12f"

    puts 'Game is finish'
    wallet_plaers()
    exit
  end
end
