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

        


        #If no winner, return false
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