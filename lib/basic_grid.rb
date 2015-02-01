require_relative 'grid_layout_description'
class BasicGrid
  include GridLayoutDescription

  def initialize(cw, ch, columns, rows)
    @horizontal_pitch = cw

    @vertical_pitch = ch

    @cell_width = cw

    @cell_height = ch

    @left_margin = 0

    @top_margin = 0

    @right_margin = 0

    @bottom_margin = 0

    @number_of_columns = columns

    @number_of_rows = rows
  end

end