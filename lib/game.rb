require "json"

#initialize Game with P1, P2, and an empty board.
class Game
    def initialize(player1 = nil, player2 = nil)
        @player1 = player1
        @player2 = player2
        @board = Array.new(7, " ") {Array.new(6, " ")}
        @winner = nil
        #@current_player = @player1
        @board_label = ['0', '1', '2', '3', '4', '5']
    end

    


    def turn()
        column_sel1 = -3 #random number to allow until loop to fxn
        column_sel2 = -3 #random number to allow until loop to fxn
        until column_sel1 >= 0 && column_sel1 < 6 do  #range of the grid.
            p "#{@player1.name}, please choose the column for your move, 0-6, or you can type 'save' to save the game"
            column_sel1 = gets.chomp
            if column_sel1 == "save"
                save_game
                return
                
            end
            
            column_sel1 = column_sel1.to_i
        end
        place_token(@player1, column_sel1)


        if check_win == true #check win conditions,
            return
        end

        until column_sel2 >= 0 && column_sel2 < 6 do
            p "#{@player2.name}, please choose the column for your move, 0-6"
            column_sel2 = gets.chomp.to_i
        end
        place_token(@player2, column_sel2)


        turn unless check_win == true #check win conditions,


        
    end

    def place_token(player, column)
        bottom_most = get_bottom(column) #get the lowest empty row.
        @board[bottom_most][column] = player.symbol
        print_board
        
        
    end
    def board
        @board
    end

    def get_bottom(column)
        @board.each_with_index  do |row, index|
            if row[column] ==(" ")
                # p index
                return index
            end
        end
    end

    def check_win
        #check horizontal
        @board.each do |row|
            # p "This is a row #{row}"
            row.each_cons(4) do |a, b, c, d|
                if a == b && b == c && c == d && a !=(" ")
                    if a == @player1.symbol
                        select_winner(@player1)
                    else
                        select_winner(@player2)
                    end
                    return true
                end
            end
        end
 

        #check vertical
        @board.transpose.each do |column|
            column.each_cons(4) do |a, b, c, d|
                if a == b && b == c && c == d && a !=(" ")
                    if a == @player1.symbol
                        select_winner(@player1)
                    else
                        select_winner(@player2)
                    end
                    return true
                end
            end
            
        end
        #check diagonal
        #+1,+1 loop
        column_index= 0

        @board.transpose.each do |column|
            column.each_with_index do |a, row|

                #Check if the next row in the diagonal is valid before checking their value.
                if !(@board[row])|| !(@board[row+1])|| !(@board[row+2]) == nil || !(@board[row+3])
                    next
                end

                #Check if the next column in the diagonal is valid before checking their value.

                if @board[row][column_index] == nil|| @board[row+1][column_index+1] == nil || @board[row+2][column_index+2] == nil || @board[row+3][column_index+3] == nil
                    next
                end
                #p "diagonal #{@board[row][column_index]}, #{@board[row+1][column_index+1]}, #{@board[row+2][column_index+2]}, #{@board[row+3][column_index+3]}"

                #If the next 3 rows and columns are valid, check if they are equal to the current row and column.
                if @board[row][column_index] == @board[row+1][column_index+1] && @board[row+1][column_index+1] == @board[row+2][column_index+2] && @board[row+2][column_index+2] == @board[row+3][column_index+3] && @board[row][column_index] !=(" ") 
                    if @board[row][column_index] == @player1.symbol
                        select_winner(@player1)
                    else
                        select_winner(@player2)
                    end
                   
                    return true
                end
            end
            column_index= column_index + 1
        end
        #+1,-1 loop
        column_index= 0
        @board.transpose.each do |column|
            
            column.each_with_index do |a, row|
                #Check if the next row in the diagonal is valid before checking their value.
                if !(@board[row])|| !(@board[row-1])|| !(@board[row-2]) == nil || !(@board[row-3])
                    next
                end

                #Check if the next column in the diagonal is valid before checking their value.

                if @board[row][column_index] == nil|| @board[row-1][column_index+1] == nil || @board[row-2][column_index+2] == nil || @board[row-3][column_index+3] == nil
                    next
                end
                #If the next 3 rows and columns are valid, check if they are equal to the current row and column.
                if @board[row][column_index] == @board[row-1][column_index+1] && @board[row-1][column_index+1] == @board[row-2][column_index+2] && @board[row-2][column_index+2] == @board[row-3][column_index+3] && @board[row][column_index] !=(" ") 
                    if @board[row][column_index] == @player1.symbol
                        select_winner(@player1)
                    else
                        select_winner(@player2)
                    end
                    return true
                end
            end
            column_index= column_index + 1
        end

        @board.each do |row| #Check if all grid elements have been used.
            if row.none?{ |unit| unit == " " }
                p "It's a tie!"
                return true
            end
        end




        


        #If no winner, return false
        return false
    end

    def select_winner(player)
        @winner = player
        p "Congrats #{player.name}. You won!}"
    end

    def return_winner
        @winner
    end


    def print_board
        print "#{@board_label}, These are the column labels \n"
        print "\n"
        @board.reverse.each do |row|
            p row
        end
    
    end

    def save_game
        p @player1
        p @player2
        Dir.mkdir("saved_games") unless Dir.exists?("saved_games")
        filename =  "saved_games/saved_game.json"
        File.open(filename, "w") do |f|
            f.puts(convert_to_json)
        end
        p "Game Saved Successfully"
    end

    def convert_to_json
        JSON.dump({
            player1: player_as_json(@player1),
            player2: player_as_json(@player2),
            board: @board
        })
    end

    def player_as_json(player)
        { name: player.name, symbol: player.symbol }
      end



    def load_game
        filename = "saved_games/saved_game.json"
        File.open(filename, "r") do |f|
            from_json(f)
        end
    end

    def from_json(file)
        json_file = JSON.parse(File.read(file))
        @player1 = Player.new(json_file['player1']['name'], json_file['player1']['symbol'])
        @player2 = Player.new(json_file['player2']['name'], json_file['player2']['symbol'])

        @board = json_file["board"]
        puts "Save was loaded successfuly"
    end
end