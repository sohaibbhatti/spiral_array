require 'rspec'

class Array
  def spiral_representation
  end

  private
end

describe '#print_spiral' do
  before do
    @a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  it 'returns a clockwise array single dimensional array' do
    @a.spiral_representation.should eql [1, 2, 3, 6, 9, 8, 7, 4, 5]
  end
end

