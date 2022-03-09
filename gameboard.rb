# frozen_string_literal: true

# Board Game in Tic Tac Toe
class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(3) { Array.new(3, nil) }
  end

  def check_availale(row, column)
    @board[row][column].nil?
  end

  def check_horizontal
    @board.each do |row|
      return row[0] if (row[0] == row[1]) && (row[1] == row[2])
    end
    nil
  end

  def check_vertical
    (0..2).each do |col|
      if (@board[0][col] == @board[1][col]) &&
         (@board[1][col] == @board[2][col])
        return @board[0][col]
      end
    end
    nil
  end

  def check_diagonal
    if (@board[0][0] == @board[1][1]) &&
       (@board[1][1] == @board[2][2])
      return @board[1][1]
    end

    nil
  end

  def check_diagonal_rev
    if (@board[2][0] == @board[1][1]) &&
       (@board[1][1] == @board[0][2])
      return @board[1][1]
    end

    nil
  end

  def check_win
    results = [check_horizontal, check_vertical, check_diagonal, check_diagonal_rev]
    results.each do |result|
      return result unless result.nil?
    end
    nil
  end

  def to_s
    @board.each do |row|
      row.each do |space|
        if space
          print(" #{space} |")
        else
          print '   |'
        end
      end
      print "\n"
    end
  end
end
