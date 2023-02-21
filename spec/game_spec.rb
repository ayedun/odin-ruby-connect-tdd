require "./lib/game.rb"
describe Game do
    subject(:player1) {double("player1", name: "Lucas", symbol: "●")}
    subject(:player2) {double("player2", name: "Tim", symbol: "○")}
    subject(:game) {described_class.new(player1, player2)}
    



    context "player1 places token" do
        let (:column) {3}
        let (:column3) {3}
        let (:column4) {4}
        let (:column5) {5}
        let (:column2) {2}

        let (:row) {2}
    
        it "should land on the bottom of the chosen column" do
            game.place_token(player1, column)
            expect(game.board[0][column]).to eq(player1.symbol)
            game.print_board
            expect(game.check_win).to eq(false)

        end
        it "should land at the bottom-most of the chosen column(twice)" do
            game.place_token(player1, column)
            expect(game.board[0][column]).to eq(player1.symbol)
            game.place_token(player1, column)
            expect(game.board[1][column]).to eq(player1.symbol)

            game.print_board
            expect(game.check_win).to eq(false)

        end
        it "should land at the bottom-most of the chosen column(p1, p2, p1)" do
            game.place_token(player1,column)
            expect(game.board[0][column]).to eq(player1.symbol)
            game.place_token(player2,column)
            expect(game.board[1][column]).to eq(player2.symbol)
            game.place_token(player1,column)
            expect(game.board[2][column]).to eq(player1.symbol)
            game.print_board
            expect(game.check_win).to eq(false)

        end
    end

    context "Row-based wins" do
        let (:row) {2}
        let (:column2) {2}
        let (:column) {3}
        let (:column3) {3}
        let (:column4) {4}
        let (:column5) {5}
        #row-focused tests
        it "p1 has 4 in a row" do
            game.place_token(player1,column2)
            expect(game.board[0][column2]).to eq(player1.symbol)
            game.place_token(player2,column3)
            expect(game.board[0][column3]).to eq(player2.symbol)
            game.place_token(player1,column4)
            expect(game.board[0][column4]).to eq(player1.symbol)
            game.place_token(player1,column5)
            expect(game.board[0][column5]).to eq(player1.symbol)
            
            game.place_token(player1,column3)
            expect(game.board[1][column3]).to eq(player1.symbol)
            
            game.place_token(player1,column4)
            expect(game.board[1][column4]).to eq(player1.symbol)
            
            game.place_token(player1,column5)
            expect(game.board[1][column5]).to eq(player1.symbol)
            
            game.place_token(player1,column2)
            expect(game.board[1][column2]).to eq(player1.symbol)
            game.print_board

            expect(game.check_win).to eq(true)
            expect(game.return_winner).to eq(player1)

        end

        it "p2 has 4 in a row" do
            
            game.place_token(player2,column3)
            expect(game.board[0][column3]).to eq(player2.symbol)
            
            game.place_token(player2,column4)
            expect(game.board[0][column4]).to eq(player2.symbol)
            
            game.place_token(player2,column5)
            expect(game.board[0][column5]).to eq(player2.symbol)
            
            game.place_token(player2,column2)
            expect(game.board[0][column2]).to eq(player2.symbol)
            game.print_board

            expect(game.check_win).to eq(true)
            expect(game.return_winner).to eq(player2)

        end

        it "pattern is p1,p1,p2,p1 in a row" do
            
            game.place_token(player1,column2)
            expect(game.board[0][column2]).to eq(player1.symbol)
            
            game.place_token(player1,column3)
            expect(game.board[0][column3]).to eq(player1.symbol)
            
            game.place_token(player2,column4)
            expect(game.board[0][column4]).to eq(player2.symbol)
            
            game.place_token(player1,column5)
            expect(game.board[0][column5]).to eq(player1.symbol)
            game.print_board

            expect(game.check_win).to eq(false)
            expect(game.return_winner).to be_nil


        end
    end

    context "Column-based wins" do
        let (:row0) {0}
        let (:row1) {1}
        let (:row2) {2}
        let (:row3) {3}
        let (:row4) {4}
        let (:column2) {2}
        let (:column3) {3}
        let (:column4) {4}

        it "p1 has 4 in a column" do
            game.place_token(player2,column2)
            expect(game.board[row0][column2]).to eq(player2.symbol)
            game.place_token(player1,column2)
            expect(game.board[row1][column2]).to eq(player1.symbol)
            
            game.place_token(player1,column2)
            expect(game.board[row2][column2]).to eq(player1.symbol)
            
            game.place_token(player1,column2)
            expect(game.board[row3][column2]).to eq(player1.symbol)
            
            game.place_token(player1,column2)
            expect(game.board[row4][column2]).to eq(player1.symbol)
            game.print_board

            expect(game.check_win).to eq(true)
            expect(game.return_winner).to eq(player1)

        end

        it "p2 has 4 in a column" do
            
            game.place_token(player2,column2)
            expect(game.board[row0][column2]).to eq(player2.symbol)
            
            game.place_token(player2,column2)
            expect(game.board[row1][column2]).to eq(player2.symbol)
            
            game.place_token(player2,column2)
            expect(game.board[row2][column2]).to eq(player2.symbol)
            
            game.place_token(player2,column2)
            expect(game.board[row3][column2]).to eq(player2.symbol)
            game.print_board

            expect(game.check_win).to eq(true)
            expect(game.return_winner).to eq(player2)

        end

        it "pattern is p1,p1,p2,p1 in a column" do
            
            game.place_token(player1,column2)
            expect(game.board[0][column2]).to eq(player1.symbol)
            
            game.place_token(player1,column2)
            expect(game.board[1][column2]).to eq(player1.symbol)
            
            game.place_token(player2,column2)
            expect(game.board[2][column2]).to eq(player2.symbol)
            
            game.place_token(player1,column2)
            expect(game.board[3][column2]).to eq(player1.symbol)
            game.print_board

            expect(game.check_win).to eq(false)
            expect(game.return_winner).to be_nil


        end
    end

    context "Diagonal-based wins" do
        let (:row0) {0}
        let (:row1) {1}
        let (:row2) {2}
        let (:row3) {3}
        let (:row4) {4}
        let (:row5) {5}
        let (:column0) {0}
        let (:column1) {1}
        let (:column2) {2}
        let (:column3) {3}
        let (:column4) {4}        
        let (:column5) {5}

        it "p1 has 4 in a +1,+1 diagonal" do
            game.place_token(player1,column0)
            expect(game.board[row0][column0]).to eq(player1.symbol)
            game.place_token(player2,column1)
            expect(game.board[row0][column1]).to eq(player2.symbol)
            game.place_token(player1,column1)
            expect(game.board[row1][column1]).to eq(player1.symbol)
            game.place_token(player2,column2)
            expect(game.board[row0][column2]).to eq(player2.symbol)
            game.place_token(player2,column2)
            expect(game.board[row1][column2]).to eq(player2.symbol)
            game.place_token(player1,column2)
            expect(game.board[row2][column2]).to eq(player1.symbol)
            game.place_token(player2,column3)
            expect(game.board[row0][column3]).to eq(player2.symbol)
            game.place_token(player2,column3)
            expect(game.board[row1][column3]).to eq(player2.symbol)
            game.place_token(player2,column3)
            expect(game.board[row2][column3]).to eq(player2.symbol)
            game.place_token(player1,column3)
            expect(game.board[row3][column3]).to eq(player1.symbol)
            expect(game.check_win).to eq(true)
            game.print_board

        end

        it "Diagonal pattern: p1,p1,p2,p1" do
            game.place_token(player1,column0)
            expect(game.board[row0][column0]).to eq(player1.symbol)
            game.place_token(player2,column1)
            expect(game.board[row0][column1]).to eq(player2.symbol)
            game.place_token(player1,column1)
            expect(game.board[row1][column1]).to eq(player1.symbol)
            game.place_token(player2,column2)
            expect(game.board[row0][column2]).to eq(player2.symbol)
            game.place_token(player2,column2)
            expect(game.board[row1][column2]).to eq(player2.symbol)
            game.place_token(player2,column2)
            expect(game.board[row2][column2]).to eq(player2.symbol)
            game.place_token(player2,column3)
            expect(game.board[row0][column3]).to eq(player2.symbol)
            game.place_token(player2,column3)
            expect(game.board[row1][column3]).to eq(player2.symbol)
            game.place_token(player2,column3)
            expect(game.board[row2][column3]).to eq(player2.symbol)
            game.place_token(player1,column3)
            expect(game.board[row3][column3]).to eq(player1.symbol)
            expect(game.check_win).to eq(false)
            game.print_board

        end

        it "p2 has 4 in a  +1 ,1diagonal" do
            game.place_token(player2,column0)
            expect(game.board[row0][column0]).to eq(player2.symbol)
            game.place_token(player1,column1)
            expect(game.board[row0][column1]).to eq(player1.symbol)
            game.place_token(player2,column1)
            expect(game.board[row1][column1]).to eq(player2.symbol)
            game.place_token(player1,column2)
            expect(game.board[row0][column2]).to eq(player1.symbol)
            game.place_token(player1,column2)
            expect(game.board[row1][column2]).to eq(player1.symbol)
            game.place_token(player2,column2)
            expect(game.board[row2][column2]).to eq(player2.symbol)
            game.place_token(player1,column3)
            expect(game.board[row0][column3]).to eq(player1.symbol)
            game.place_token(player1,column3)
            expect(game.board[row1][column3]).to eq(player1.symbol)
            game.place_token(player1,column3)
            expect(game.board[row2][column3]).to eq(player1.symbol)
            game.place_token(player2,column3)
            expect(game.board[row3][column3]).to eq(player2.symbol)
            expect(game.check_win).to eq(true)
            game.print_board

        end

        it "p1 has 4 in a +1,-1 diagonal" do
            game.place_token(player2,column1)
            expect(game.board[row0][column1]).to eq(player2.symbol)
            game.place_token(player2,column1)
            expect(game.board[row1][column1]).to eq(player2.symbol)
            game.place_token(player1,column1)
            expect(game.board[row2][column1]).to eq(player1.symbol)
            game.place_token(player1,column1)
            expect(game.board[row3][column1]).to eq(player1.symbol)

            game.place_token(player1,column2)
            expect(game.board[row0][column2]).to eq(player1.symbol)
            game.place_token(player2,column2)
            expect(game.board[row1][column2]).to eq(player2.symbol)
            game.place_token(player1,column2)
            expect(game.board[row2][column2]).to eq(player1.symbol)

            game.place_token(player1,column3)
            expect(game.board[row0][column3]).to eq(player1.symbol)
            game.place_token(player1,column3)
            expect(game.board[row1][column3]).to eq(player1.symbol)

            game.place_token(player1,column4)
            expect(game.board[row0][column4]).to eq(player1.symbol)
            game.print_board

            expect(game.check_win).to eq(true)


        end
        

    end
    
end