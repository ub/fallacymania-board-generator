require 'rspec'
require 'spec_helper'
require 'grid_layout_description'

class TestSubject
include  GridLayoutDescription
  def initialize(rows, columns)
    @number_of_columns = columns
    @number_of_rows    = rows
  end
end

describe GridLayoutDescription do
  subject { TestSubject.new(3,2) }

  it 'must iterate over grid indices columnwise' do
    expect(subject.each_cell_index.entries).to eq([[0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1]])
  end
end
