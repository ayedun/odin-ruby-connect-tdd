class Game
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @board = Array.new(7, " ") {Array.new(6, " ")}
        #@current_player = @player1
    end

    def place_token(player, column)
        bottom_most = get_bottom(column)
        p bottom_most
        @board[bottom_most][column] = player.symbol
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
        @board.each_cons(4) do |a, b, c, d|
            if a == b && b == c && c == d && a != " "
                return true
            end
        end

        #check vertical
        #check diagonal
    end

    def print_board
        @board.reverse.each do |row|
            p row
        end
    
    end
end