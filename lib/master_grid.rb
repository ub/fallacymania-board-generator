require_relative 'grid_layout_description'
class MasterGrid
  include GridLayoutDescription

  def initialize
    @horizontal_pitch = 636.5

    @vertical_pitch = 180.4

    @cell_width = 634

    @cell_height = 178

    @left_margin = 0

    @top_margin = 0

    @right_margin = 0

    @bottom_margin = 0

    @number_of_columns = 2

    @number_of_rows = 30
  end
end

