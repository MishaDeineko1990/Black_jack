require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Game < Deck
  attr_reader :player, :dealer
  attr_accessor :move_players, :decision_finish_raund_dealer

  def initialize(player_name)
    super()
    @MAX_COUNT_CARDS ||= 3
    @MAX_POINTS ||= 21
    @BET_FOR_RAUND ||= 10
    @NUMBER_OF_PLAYERS ||= 2
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @decision_finish_raund_dealer =  false
    @decision_finish_raund_player =  false
    @player_pass = false
  end

  def start_round
    full_deck_cards
    @player.clean_hend
    @dealer.clean_hend
    @NUMBER_OF_PLAYERS.times { @player.add_card(get_card) }
    @NUMBER_OF_PLAYERS.times { @dealer.add_card(get_card) }
    @player.send_money(@BET_FOR_RAUND)
    @dealer.send_money(@BET_FOR_RAUND)
    @bank = @BET_FOR_RAUND * @NUMBER_OF_PLAYERS
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

  def decide_dealer_move(player)
    return player.decide_dealer_move(self) if player.name == 'dealer'

    puts ''
    puts 'You step!!!'
    puts '-----------------------'
    puts 'Write 1 to open cards'
    puts 'Write 2 to take card' if player.hend.count < @MAX_COUNT_CARDS
    puts 'Write 3 to pass' if player.hend.count < @MAX_COUNT_CARDS || !@player_pass 
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
      @decision_finish_raund_player = true
      @player_pass = true
      nil
    else
      puts 'Invalid input. Please try again.'
      decide_dealer_move(player)
    end
  end

  def finish_raund?
    return true if @player.hend.count == @MAX_COUNT_CARDS && @dealer.hend.count == @MAX_COUNT_CARDS
    return true if @decision_finish_raund_dealer && @decision_finish_raund_player
    return true if @player.count_points > @MAX_POINTS

    false
  end

  def finish_raund
    @decision_finish_raund_dealer = false
    @decision_finish_raund_player = false
    show_cards(false)
    case winner
    when 'draw'
      @player.get_money(@bank / @NUMBER_OF_PLAYERS)
      @dealer.get_money(@bank / @NUMBER_OF_PLAYERS)
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
    @player_pass = false

    exit_game if @dealer.wallet < @BET_FOR_RAUND || @player.wallet < @BET_FOR_RAUND
    puts 'Enter "end" if you want to finish the game if not enter enything.'
    finish_game = gets.chomp.downcase
    exit_game if finish_game == 'end'
  end

  def winner
    player_points = @player.count_points
    dealer_points = @dealer.count_points

    return 'draw' if player_points == dealer_points

    if player_points > @MAX_POINTS && dealer_points > @MAX_POINTS
      return @player if dealer_points > player_points

      return @dealer
    end
    return @player if dealer_points > @MAX_POINTS
    return @dealer if player_points > @MAX_POINTS
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
