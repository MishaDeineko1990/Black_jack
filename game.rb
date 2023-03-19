require_relative 'black_jeck_core'
require_relative 'player'
require_relative 'dealer'

class Game < BlackJeckCore
  attr_reader :player, :dealer
  attr_accessor :move_players, :decision_finish_raund_dealer

  def initialize
    super
    puts 'Enter your name:'
    player_name = gets.chomp
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @decision_finish_raund_dealer =  false
    @decision_finish_raund_player =  false
    @count_pass = 0
  end

  def start_round
    full_deck_cards
    @player.clean_hend
    @dealer.clean_hend
    2.times { @player.add_card(get_card) }
    2.times { @dealer.add_card(get_card) }
    @player.send_money(10)
    @dealer.send_money(10)
    @bank = 20
  end

  def show_cards(hide_dealer_cards)
    puts "#{@dealer.name} cards on hand: #{cards_on_hand(@dealer.hend, hide_dealer_cards)}"
    puts "#{@player.name} cards on hand: #{cards_on_hand(@player.hend)}"
  end

  def cards_on_hand(cards, close_card = false)
    s_out = ''
    point_counts = 0

    if close_card
      s_out = '[**] ' * cards.count
    else
      cards.each do |card|
        s_out += "[#{card[:name]}] "
        point_counts += card[:point]
      end
      "#{s_out}#{point_counts}"
    end
  end

  def make_move(player)
    return player.move_action(self) if player.name == 'dealer'

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
      nil
    when '2'
      player.add_card(get_card)
      @decision_finish_raund_player = true
      nil
    when '3'
      @count_pass = 1
      nil
    else
      puts 'Invalid input. Please try again.'
    end
  end

  def finish_raund?
    return true if @player.hend.count == 3 && @dealer.hend.count == 3
    return true if @decision_finish_raund_dealer && @decision_finish_raund_player
    return true if @player.count_points > 21

    false
  end

  def finish_raund
    @decision_finish_raund_dealer = false
    @decision_finish_raund_player = false
    show_cards(false)
    case winner
    when 'draw'
      @player.get_money(@bank / 2)
      @dealer.get_money(@bank / 2)
    when @player
      @player.get_money(@bank)
    else
      @dealer.get_money(@bank)
    end

    output_resault

    @bank = 0
    @deck_cards = []
    @player.hend = []
    @dealer.hend = []

    exit_game if @dealer.wallet < 10 || @player.wallet < 10
    puts 'Enter "end" if you want to finish the game if not enter enything.'
    finish_game = gets.chomp.downcase
    exit_game if finish_game == 'end'
  end

  def winner
    player_points = @player.count_points
    dealer_points = @dealer.count_points

    return 'draw' if player_points == dealer_points

    if player_points > 21 && dealer_points > 21
      return @player if dealer_points > player_points

      return @dealer
    end
    return @player if dealer_points > 21
    return @dealer if player_points > 21
    return @player if player_points > dealer_points

    @dealer
  end

  def output_resault
    result = {
      'draw' => '-----------Draw-------------',
      @player => '-----------YOU WIN-------------',
      !@player => '-----------Dealer wins----------'
    }[winner]

    puts result
    wallet_plaers
  end

  def wallet_plaers
    puts "#{@dealer.name} have on wallet #{@dealer.wallet}$"
    puts "#{@player.name} have on wallet #{@player.wallet}$"
    puts '----------------------------'
  end

  def exit_game
    puts 'Game is finish'
    wallet_plaers
    exit
  end
end
