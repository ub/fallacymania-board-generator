module GridLayoutDescription
  # distance between the left edges of adjacent cells .
  attr_accessor :horizontal_pitch

  # distance between the upper edge of a cell  and the upper edge of the cell  directly below.
  attr_accessor :vertical_pitch
  attr_accessor :cell_width
  attr_accessor :cell_height

  # distance from the left edge of the canvas to the left edge of the first cell .
  attr_accessor :left_margin

  # distance from the top edge of the canvas to the top of the first cell .
  attr_accessor :top_margin
  attr_accessor :right_margin
  attr_accessor :bottom_margin
  attr_accessor :number_of_columns
  attr_accessor :number_of_rows

  def canvas_width
    horizontal_pitch * number_of_columns + left_margin + right_margin
  end

  def canvas_height
    vertical_pitch * number_of_rows + top_margin + bottom_margin
  end

  # column-first iterator
  def each_cell_index
    if block_given?
      self.number_of_columns.times do |c|
        self.number_of_rows.times do |r|
          yield [r, c]
        end
      end
    else
      self.enum_for(:each_cell_index)
    end
  end

  def each_cell_topleft
    if block_given?
      self.each_cell_index do | r, c |
        yield [ (top_margin + r * vertical_pitch).to_i, (left_margin + c * horizontal_pitch).to_i ]
      end
    else
      self.enum_for(:each_cell_topleft)
    end
  end


end

