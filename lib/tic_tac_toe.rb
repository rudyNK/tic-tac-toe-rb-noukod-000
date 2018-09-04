require 'pry'
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
@@ -9,11 +11,24 @@
  [6,4,2]
]
def play(board)
  puts "Welcome to Tic Tac Toe!"
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "--------"
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "--------"
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
@@ -23,8 +38,8 @@ def valid_move?(board, input)
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position(board, combo[0]) == position(board, combo[1]) &&
    position(board, combo[1]) == position(board, combo[2]) &&
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end
@@ -33,22 +48,24 @@ def draw?(board)
  !won?(board) && board.all?{|token| token == "X" || token == "O"}
end
def over?(board)
  won?(board) || draw?(board)
end
def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if !valid_move?(board, input)
    turn(board)
  end
  move(board, input)
end
def position(board, location)
  board[location.to_i]
  move(board, input, current_player(board))
end
def position_taken?(board, location)
  !(position(board, location).nil? || position(board, location) == "")
  !(board[location].nil? || board[location] == " ")
  # Creates a stop on RSpec
  # !(board[location].nil? || board[location] == "")
end
def current_player(board)
@@ -59,26 +76,12 @@ def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end
def move(board, location)
  if valid_move?(board, location)
    board[location.to_i-1] = current_player(board)
  end
def move(board, location, player = "X")
  board[location.to_i-1] = player
end
def winner(board)
  if winning_combo = won?(board)
    position(board, winning_combo.first)
    board[winning_combo.first]
  end
end
board = Array.new(9)
puts "Welcome to Tic Tac Toe"
while !(won?(board) || draw?(board))
  turn(board)
end
if won?(board)
  puts "Congratulations! #{winner(board)}"
elsif draw?(board)
  puts "Cats Game!"
end
end 
