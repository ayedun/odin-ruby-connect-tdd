require_relative "./game.rb"
require_relative "./player.rb"

def get_player_name_and_symbol(player_num = 1) 
    
    
    
    
    p "Player #{player_num}, Please enter your name:"
    name = gets.chomp
    p "Please enter your symbol(It can be any single character you'd like(except space)):"
    symbol = gets.chomp
    player = Player.new(name, symbol)
    return player
end



decision = nil
until decision == 'new' || decision =='load' do
    puts "Please type 'new' to start a new game, or 'load' to load an old game"
    decision = gets.chomp
end
if decision == 'new'

    player1 =get_player_name_and_symbol()
    player2 =get_player_name_and_symbol(2)
    game = Game.new(player1, player2)
    p "Let the game commence!"
        

    game.turn

elsif decision == 'load'
    game = Game.new()
    game.load_game
    p "Let the game commence!"

    game.turn
end

# game.turn




#begin working on game turn






