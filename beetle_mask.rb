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
  def initialize(outside_rows=3, outside_columns=3, visual=true)
    @history = []
    @row_count = outside_rows * 2 - 1
    @column_count = outside_columns * 2 - 1
    @board = Array.new(@row_count) { Array.new(@column_count, nil) }
    @row_count.times do |row_index|
      @column_count.times do |column_index|
        if row_index % 2 == column_index % 2
          if row_index == @row_count / 2 && column_index == @column_count / 2
            @board[row_index][column_index] = false
          else
            @board[row_index][column_index] = true
          end
        end
      end
    end
    visualize if @visualize = visual
  end

  attr_reader :history

  def visualize
    puts '  ' + (0...@board.size).to_a.join(' ')
    @board.each_with_index do |row, row_index|
      print row_index
      row.each_with_index do |cell, _column_index|
        if cell == true
          print ' x'
        elsif cell == false
          print ' o'
        else
          print ' -'
        end
      end
      print "\n"
    end
    nil
  end

  def move_up(row, column)
    if move_up?(row, column)
      @board[row][column] = false
      @board[row - 2][column] = false
      @board[row - 4][column] = true
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_down(row, column)
    if move_down?(row, column)
      @board[row][column] = false
      @board[row + 2][column] = false
      @board[row + 4][column] = true
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_left(row, column)
    if move_left?(row, column)
      @board[row][column] = false
      @board[row][column - 2] = false
      @board[row][column - 4] = true
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_right(row, column)
    if move_right?(row, column)
      @board[row][column] = false
      @board[row][column + 2] = false
      @board[row][column + 4] = true
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_up_left(row, column)
    if move_up_left?(row, column)
      @board[row][column] = false
      @board[row - 1][column - 1] = false
      @board[row - 2][column - 2] = true
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_up_right(row, column)
    if move_up_right?(row, column)
      @board[row][column] = false
      @board[row - 1][column + 1] = false
      @board[row - 2][column + 2] = true
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_down_left(row, column)
    if move_down_left?(row, column)
      @board[row][column] = false
      @board[row + 1][column - 1] = false
      @board[row + 2][column - 2] = true
    else
      raise "Tried to #{__method__} at #{row}, #{column}"
    end
    @history << [__method__, row, column]
    visualize if @visualize
    self
  end

  def move_down_right(row, column)
    if move_down_right?(row, column)
      @board[row][column] = false
      @board[row + 1][column + 1] = false
      @board[row + 2][column + 2] = true
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
      @board[row - 2][column] == true && @board[row - 4][column] == false
    end
  end

  def move_down?(row, column)
    if row + 4 >= @row_count
      false
    else
      @board[row + 2][column] == true && @board[row + 4][column] == false
    end
  end

  def move_left?(row, column)
    if column - 4 < 0
      false
    else
      @board[row][column - 2] == true && @board[row][column - 4] == false
    end
  end

  def move_right?(row, column)
    if column + 4 >= @column_count
      false
    else
      @board[row][column + 2] == true && @board[row][column + 4] == false
    end
  end

  def move_up_left?(row, column)
    if row - 2 < 0 || column - 2 < 0
      false
    else
      @board[row - 1][column - 1] == true && @board[row - 2][column - 2] == false
    end
  end

  def move_up_right?(row, column)
    if row - 2 < 0 || column + 2 >= @column_count
      false
    else
      @board[row - 1][column + 1] == true && @board[row - 2][column + 2] == false
    end
  end

  def move_down_left?(row, column)
    if row + 2 >= @row_count || column - 2 < 0
      false
    else
      @board[row + 1][column - 1] == true && @board[row + 2][column - 2] == false
    end
  end

  def move_down_right?(row, column)
    if row + 2 >= @row_count || column + 2 >= @column_count
      false
    else
      @board[row + 1][column + 1] == true && @board[row + 2][column + 2] == false
    end
  end

  def get_legal_moves
    move_methods = %w(move_up? move_down? move_left? move_right? move_up_left? move_up_right? move_down_left? move_down_right?)
    legal_moves = []
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell == true
          move_methods.each do |move|
            legal_moves << [move.chomp('?'), row_index, column_index] if send(move, row_index, column_index)
          end
        end
      end
    end
    legal_moves
  end

  def won?
    @board.flatten.select { |cell| cell == true}.count == 1
  end

  def lost?
    !won? && get_legal_moves.count == 0
  end

  def deep_copy
    dc = self.class.new((@row_count+1)/2, (@column_count+1)/2, @visualize)
    self.history.each do |move, row, column|
      dc.send(move, row, column)
    end
    dc
  end
end
