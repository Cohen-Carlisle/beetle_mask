def solve(beetle_mask)
  solutions = []
  solve_recursive(beetle_mask, solutions)
  solutions
end

def solve_recursive(beetle_mask, solutions)
  if beetle_mask.won?
    solutions << beetle_mask.history
  elsif beetle_mask.lost?
    nil
  else
    beetle_mask.get_legal_moves.each do |move, row, column|
      solve_recursive(beetle_mask.deep_copy.send(move, row, column), solutions)
    end
  end
  nil
end

class BeetleMask
  def initialize(board="X_X_X\n_X_X_\nX_O_X\n_X_X_\nX_X_X", visual=true)
    @board = board.split("\n")
    @row_count = @board.length
    @column_count = @board.length
    @history = []
    @visualize = visual
    visualize if @visualize
  end

  attr_reader :history
  attr_accessor :visualize

  def visualize
    puts @board
  end

  def move_up(row, column)
    if move_up?(row, column)
      @board[row][column] = 'O'
      @board[row - 2][column] = 'O'
      @board[row - 4][column] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_down(row, column)
    if move_down?(row, column)
      @board[row][column] = 'O'
      @board[row + 2][column] = 'O'
      @board[row + 4][column] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_left(row, column)
    if move_left?(row, column)
      @board[row][column] = 'O'
      @board[row][column - 2] = 'O'
      @board[row][column - 4] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_right(row, column)
    if move_right?(row, column)
      @board[row][column] = 'O'
      @board[row][column + 2] = 'O'
      @board[row][column + 4] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_up_left(row, column)
    if move_up_left?(row, column)
      @board[row][column] = 'O'
      @board[row - 1][column - 1] = 'O'
      @board[row - 2][column - 2] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_up_right(row, column)
    if move_up_right?(row, column)
      @board[row][column] = 'O'
      @board[row - 1][column + 1] = 'O'
      @board[row - 2][column + 2] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_down_left(row, column)
    if move_down_left?(row, column)
      @board[row][column] = 'O'
      @board[row + 1][column - 1] = 'O'
      @board[row + 2][column - 2] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_down_right(row, column)
    if move_down_right?(row, column)
      @board[row][column] = 'O'
      @board[row + 1][column + 1] = 'O'
      @board[row + 2][column + 2] = 'X'
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_up?(row, column)
    if row - 4 < 0
      false
    else
      @board[row - 2][column] == 'X' && @board[row - 4][column] == 'O'
    end
  end

  def move_down?(row, column)
    if row + 4 >= @row_count
      false
    else
      @board[row + 2][column] == 'X' && @board[row + 4][column] == 'O'
    end
  end

  def move_left?(row, column)
    if column - 4 < 0
      false
    else
      @board[row][column - 2] == 'X' && @board[row][column - 4] == 'O'
    end
  end

  def move_right?(row, column)
    if column + 4 >= @column_count
      false
    else
      @board[row][column + 2] == 'X' && @board[row][column + 4] == 'O'
    end
  end

  def move_up_left?(row, column)
    if row - 2 < 0 || column - 2 < 0
      false
    else
      @board[row - 1][column - 1] == 'X' && @board[row - 2][column - 2] == 'O'
    end
  end

  def move_up_right?(row, column)
    if row - 2 < 0 || column + 2 >= @column_count
      false
    else
      @board[row - 1][column + 1] == 'X' && @board[row - 2][column + 2] == 'O'
    end
  end

  def move_down_left?(row, column)
    if row + 2 >= @row_count || column - 2 < 0
      false
    else
      @board[row + 1][column - 1] == 'X' && @board[row + 2][column - 2] == 'O'
    end
  end

  def move_down_right?(row, column)
    if row + 2 >= @row_count || column + 2 >= @column_count
      false
    else
      @board[row + 1][column + 1] == 'X' && @board[row + 2][column + 2] == 'O'
    end
  end

  def get_legal_moves
    move_methods = %w(move_up? move_down? move_left? move_right? move_up_left? move_up_right? move_down_left? move_down_right?)
    legal_moves = []
    @board.each_with_index do |row, row_index|
      row.chars.each_with_index do |cell, column_index|
        if cell == 'X'
          move_methods.each do |move|
            legal_moves << [move.chomp('?'), row_index, column_index] if send(move, row_index, column_index)
          end
        end
      end
    end
    legal_moves
  end

  def won?
    @board.join.count('X') == 1
  end

  def lost?
    !won? && get_legal_moves.count == 0
  end

  def deep_copy
    dc = self.class.new(@board.join("\n"), @visualize)
    dc.instance_variable_set(:@history, self.history.map(&:dup))
    dc
  end
end
