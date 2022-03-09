# frozen_string_literal: true

require_relative 'player'
require_relative 'gameboard'

# GamePlay class for Tic Tac Toe
class GamePlay
  def initialize
    @number_of_match = 0
    @game_board = GameBoard.new
    create_player
    @empty_space = 9
    @winner = nil
    @record_winners = {}
  end

  def create_player
    puts 'Player 1'
    @player1 = Player.new
    print 'Choose your sign (X/O): '
    @player1.sign = gets.chomp
    puts 'Player 2'
    @player2 = Player.new
    @player2.sign = @player1.sign == 'X' ? 'O' : 'X'
  end

  def player_check_move(player)
    loop do
      new_move = player.make_move
      x = new_move[0]
      y = new_move[1]
      if @game_board.check_availale(x, y)
        @game_board.board[x][y] = player.sign
        break
      end
      puts 'Space not available. Please check input and try again'
    end
  end

  def who_win(result)
    if result == @player1.sign
      @player1.win
      return @player1
    end
    if result == @player2.sign
      @player2.win
      return @player2
    end
    nil
  end

  def run_game_for(player)
    puts "Player #{player.name} turn"
    player_check_move(player)
    @empty_space -= 1
    puts @game_board
    who_win(@game_board.check_win)
  end

  def game_result
    if @winner.nil?
      puts "It's a draw"
    else
      puts "Player #{@winner.name} wins"
      @record_winners[@number_of_match] = @winner
    end
    puts @player1
    puts @player2
  end

  def run_one_game(player1, player2)
    reset_board
    puts "=== MATCH NUMBER #{@number_of_match += 1} ==="
    while @empty_space.positive? && @winner.nil?
      @winner = run_game_for(player1)
      break if @empty_space.zero? || @winner

      @winner = run_game_for(player2)
    end
    game_result
  end

  def reset_board
    @game_board = GameBoard.new
    @empty_space = 9
    @winner = nil
  end

  def swap; end

  def who_first
    return @player1 if @record_winners.empty?
    return @player2 if @record_winners[@number_of_match] == @player1

    @player1
  end

  def continue_game?
    print 'Do you want to continue? (y/n): '
    choice = gets.chomp
    return true if choice == 'y'

    false
  end

  def run_games
    puts "#{@player1}. #{@player2}"
    loop do
      if who_first == @player1
        run_one_game(@player1, @player2)
      else
        run_one_game(@player2, @player1)
      end

      break unless continue_game?
    end
    puts 'Thank you for playing'
  end
end
