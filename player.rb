# frozen_string_literal: true

# Player class for Tic Tac Toe
class Player
  attr_accessor :name, :sign
  attr_reader :score

  def initialize
    print 'Your name is: '
    name = gets.chomp
    @name = name
    @sign = ''
    @score = 0
  end

  def make_move
    print 'Choose row = '
    row = gets.chomp.to_i
    print 'Choose column = '
    column = gets.chomp.to_i
    [row, column]
  end

  def to_s
    "Player #{@name} (#{sign}) has #{@score} point(s)"
  end

  def win
    @score += 1
  end
end
