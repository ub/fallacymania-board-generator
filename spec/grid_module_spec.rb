require 'rspec'
require 'spec_helper'
require 'grid_layout_description'

module Test
  class Subject
    include  GridLayoutDescription
    def initialize(rows, columns)
      @number_of_columns = columns
      @number_of_rows    = rows

      @horizontal_pitch = 23
      @vertical_pitch = 7

      @left_margin = 0
      @top_margin = 0
      @right_margin = 0
      @bottom_margin = 0

    end
  end
end

describe GridLayoutDescription do
  subject { Test::Subject.new(3,2) }

  it 'must iterate over grid indices columnwise' do
    expect(subject.each_cell_index.entries).to eq([[0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1]])
  end

  it 'must iterate top-left positions columnwise' do
    expect(subject.each_cell_topleft.entries).to eq([[0, 0], [7, 0], [14, 0], [0, 23], [7, 23], [14, 23]])
  end

  describe '#canvas_width' do
    it 'should be equal to the product of number of columns by horizontal_pitch (zero margins)' do
      expect(subject.canvas_width).to eq(46)
    end
  end

  describe '#canvas_height' do
    it 'should be equal to the product of number of rows by vertical_pitch (zero margins)' do
      expect(subject.canvas_height).to eq(21)
    end
  end


end
