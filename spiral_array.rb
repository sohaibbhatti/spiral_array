require 'rspec'

class Array
  #  Example ( 3 x 3 )
  #  1 2 3
  #  4 5 6 => 1 2 3 6 9 8 7 4 5 6
  #  7 8 9
  #
  #  Example ( 5 x 5 )
  #  1  2  3  4  5
  #  6  7  8  9  10
  #  11 12 13 14 15 => 1 2 3 4 5 10 15 20 25 24 23 22 21 16 11 6 7 8 9 14 19 18 17 12 13
  #  16 17 18 19 20
  #  21 22 23 24 25
  def to_spiral_array
    @spiral_array.clear if @spiral_array
    recurse_top_left_to_bottom_right 0, 0, self.first.size - 1, self.size - 1
    @spiral_array
  end

  private

  # Traverses a multidimensional array in an L shape manner from
  # the top left to the bottom right
  def top_left_to_bottom_right(x1, y1, x2, y2)
    @spiral_array ||= []

    # Traversing top left to top right
    (x1..x2).each do |i|
      @spiral_array << self[y1][i]
    end

    # Traversing top right to bottom right
    ((y1 + 1)..(y2)).each do |j|
      @spiral_array << self[j][x2]
    end

    @spiral_array
  end

  # Traverses a multidimensional array in an L shape manner from
  # the bottom right to the top left
  def bottom_right_to_top_left(x1, y1, x2, y2)
    temp_array = []
    @spiral_array ||= []

    # Traversing bottom right to bottom left
    (x2).downto(x1).each do |i|
      temp_array << self[y2][i]
      @spiral_array << self[y2][i]
    end

    # Traversing bottom left to top left
    (y2 - 1).downto(y1).each do |j|
      temp_array << self[j][x1]
      @spiral_array << self[j][x1]
    end

    @spiral_array
  end

  # Recurrance call for the top_left_to_bottom_right method.
  # Invokes the recurrance call for the bottom_right_to_top_left
  # method. The method would be invoked on a sub array
  #  1 2 3
  #  4 5 6 => 4 5
  #  7 8 9    7 8
  def recurse_top_left_to_bottom_right(x1, y1, x2, y2)
    top_left_to_bottom_right x1, y1, x2, y2
    recurse_bottom_right_to_top_left x1, y1 + 1, x2 - 1, y2 if x2 - x1 > 0
  end

  # Recurrance call for the bottom_right_to_top_left method.
  # Invokes the recurrance call for the top_left_to_bottom_right
  # method. The method would be invoked on a sub array
  #  1 2 3
  #  4 5 6 => 4 5 => 5
  #  7 8 9    7 8
  def recurse_bottom_right_to_top_left(x1, y1, x2, y2)
    bottom_right_to_top_left x1, y1, x2, y2
    recurse_top_left_to_bottom_right x1 + 1, y1, x2, y2 - 1 if x2 - x1 > 0
  end
end

describe 'Array' do
  let! (:array) { [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
  let! :big_array do
    [
      [1,  2,  3,  4,  5],
      [6,  7,  8,  9,  10],
      [11, 12, 13, 14, 15],
      [16, 17, 18, 19, 20],
      [21, 22, 23, 24, 25]
    ]
  end

  describe '#to_spiral_array' do
    it 'returns a clockwise array single dimensional array' do
      array.to_spiral_array.should eql [1, 2, 3, 6, 9, 8, 7, 4, 5]
    end

    it 'returns a clockwise array single dimensional array(EXMPLE 2)' do
      big_array.to_spiral_array.should eql %w[1 2 3 4 5 10 15 20 25 24 23 22 21 16 11 6 7 8 9 14 19 18 17 12 13].collect(&:to_i)
    end
  end

  describe '#top_left_to_bottom_right' do
    specify { array.send(:top_left_to_bottom_right, 0, 0, 2, 2).should eql [1, 2, 3, 6, 9] }
  end

  describe '#bottom_right_to_top_left' do
    specify { array.send(:bottom_right_to_top_left, 0, 0, 2, 2).should eql [9, 8, 7, 4, 1] }
  end
end
