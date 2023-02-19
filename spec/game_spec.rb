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
        let (:row) {2}
        it "should land on the bottom of the chosen column" do
            game.place_token(player1, column)
            expect(game.board[0][column]).to eq(player1.symbol)
            game.print_board
        end
        it "should land at the bottom-most of the chosen column(twice)" do
            game.place_token(player1, column)
            expect(game.board[0][column]).to eq(player1.symbol)
            game.place_token(player1, column)
            expect(game.board[1][column]).to eq(player1.symbol)
            game.print_board
        end
        it "should land at the bottom-most of the chosen column(p1, p2, p1)" do
            game.place_token(player1,column)
            expect(game.board[0][column]).to eq(player1.symbol)
            game.place_token(player2,column)
            expect(game.board[1][column]).to eq(player2.symbol)
            game.place_token(player1,column)
            expect(game.board[2][column]).to eq(player1.symbol)
            game.print_board
        end

        it "p1 has 4 in a row" do
            
            game.place_token(player1,column3)
            expect(game.board[0][column3]).to eq(player1.symbol)
            
            game.place_token(player1,column4)
            expect(game.board[0][column4]).to eq(player1.symbol)
            
            game.place_token(player1,column5)
            expect(game.board[0][column5]).to eq(player1.symbol)
            game.print_board
        end
    
    end
    
end