require_relative 'interface'
require_relative 'black_jeck_core'
require_relative 'game'
require_relative 'player'
require_relative 'dealer'

@interface = Interface.new
@interface.black_jack!
