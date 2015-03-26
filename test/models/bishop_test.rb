require 'test_helper'

class BishopTest < ActiveSupport::TestCase
	
  test "Bishop legal moves"  do
    setup_bishop
    
    assert @bishop.legal_move?(6, 7)
    assert @bishop.legal_move?(1, 2)
    assert @bishop.legal_move?(1, 6)
    assert @bishop.legal_move?(5, 6)
  end

  test "Bishop illegal moves" do
    setup_bishop

    assert_not @bishop.legal_move?(5, 7)
    assert_not @bishop.legal_move?(3, 7)
    assert_not @bishop.legal_move?(1, 4)
  end

  test "Bishop is not obstructed" do
    setup_obstruction_tests
    assert_equal false, @bishop.obstructed_move?(4, 5), "quad 1"
    assert_equal false, @bishop.obstructed_move?(4, 3), "quad 2"
    assert_equal false, @bishop.obstructed_move?(2, 3), "quad 3"
    assert_equal false, @bishop.obstructed_move?(2, 5), "quad 4"
  end

  test "Bishop(black) is obstructed by black " do
    setup_obstruction_tests
    assert_equal true, @bishop.obstructed_move?(6, 7), "quad 1"
    assert_equal true, @bishop.obstructed_move?(0, 7), "quad 4"
  end

  test "Bishop(white) is obstructed by white" do
    setup_obstruction_tests
    @bishop.update_attributes( color: true)
    @bishop.reload
  
    assert @bishop.obstructed_move?(7, 0), "quad 2"
  end

  def setup_bishop
    @bishop = FactoryGirl.create(:bishop, x_position: 3, y_position: 4, color: true)
  end

  def setup_obstruction_tests
    game = FactoryGirl.create(:game)
    @bishop = game.pieces.where( type: 'Bishop', color: false).last
    @bishop.update_attributes(x_position: 3, y_position: 4)
    game.reload

    @pawn = game.pieces.where( x_position: 5, y_position: 6).last
    @pawn2 = game.pieces.where( x_position: 5, y_position: 2).last
    @pawn3 = game.pieces.where( x_position: 1, y_position: 2).last
    @pawn4 = game.pieces.where( x_position: 1, y_position: 6).last
  end

end
