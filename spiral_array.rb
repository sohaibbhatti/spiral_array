require 'rspec'

class Array
  def to_spiral_array
    # Pending
  end


  private

  #  Sample ( 3 x 3 )
  #  1 2 3
  #  4 5 6 => 1 2 3 6 9 8 7 4 5 6
  #  7 8 9
  #
  #  Sanple ( 5 x 5 )
  #  1  2  3  4  5
  #  6  7  8  9  10
  #  11 12 13 14 15 => 1 2 3 4 5 10 15 20 25 24 23 22 21 16 11 6 7 8 9 14 19 18 17 12 13
  #  16 17 18 19 20
  #  21 22 23 24 25

  ##
  # Traverses a multidimensional array in an L shape manner from
  # the top left to the bottom right
  def top_left_to_bottom_right(x1, y1, x2, y2)
    temp_array = []

    # Traversing top left to top right
    (x1..x2).each do |i|
      temp_array << self[y1][i]
    end

    # Traversing top right to bottom right
    ((y1 + 1)..(y2)).each do |j|
      temp_array << self[j][x2]
    end

    temp_array

   # ulat a, x1, y1+1, x2 - 1, y2 if x2 - x1 > 0
  end

  ##
  # Traverses a multidimensional array in an L shape manner from
  # the bottom right to the top left
  def bottom_right_to_top_left(x1, y1, x2, y2)
    temp_array = []

    # Traversing bottom right to bottom left
    (x2).downto(x1).each do |i|
      temp_array << self[y2][i]
    end

    # Traversing bottom left to top left
    (y2 - 1).downto(y1).each do |j|
      temp_array << self[j][x1]
    end

    temp_array

    straight j, x1+1, y1, x2, y2 - 1 if x2 - x1 > 0
  end
end

describe 'Array' do
  let! (:array) { [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }

  describe '#to_spiral_array' do
    it 'returns a clockwise array single dimensional array' do
      array.to_spiral_array.should eql [1, 2, 3, 6, 9, 8, 7, 4, 5]
    end
  end

  describe '#top_left_to_bottom_right' do
    specify { array.send(:top_left_to_bottom_right, 0, 0, 2, 2).should eql [1, 2, 3, 6, 9] }
  end

  describe '#bottom_right_to_top_left' do
    specify { array.send(:bottom_right_to_top_left, 0, 0, 2, 2).should eql [9, 8, 7, 4, 1] }
  end
end
