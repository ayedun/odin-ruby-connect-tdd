class Game
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @board = Array.new(7, " ") {Array.new(6, " ")}
        @winner = nil
        #@current_player = @player1
    end

    def place_token(player, column)
        bottom_most = get_bottom(column)
        @board[bottom_most][column] = player.symbol
        check_win
        # p get_bottom(column)
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

        return false
    end

    def select_winner(player)
        @winner = player
        "Congrats #{player.name}. You won!}"
    end

    def return_winner
        @winner
    end


    def print_board
        @board.reverse.each do |row|
            p row
        end
    
    end
end