require 'RMagick'

require_relative 'lib/master_compatible_grid'
require_relative 'lib/master_grid_description_map'

SOURCE_FILENAME = '5x12.png'
TARGET_FILENAME = '5x12n.png'

img = Magick::Image.read(SOURCE_FILENAME).first


def write_number(img, x, y, num)
  canvas = Magick::Draw.new
  num_s = num.to_s
  num_s = ' ' + num_s if num_s.size < 2
  canvas.annotate(img, 0, 0, x+6, y+20, num_s) do
    self.font = "Trebuchet Ms"
    self.font_weight = Magick::BoldWeight
    self.pointsize = 18
    self.fill = 'transparent'
    self.stroke = 'white'
    self.stroke_width = 1.5
  end
end


grid_5x11 = MasterCompatibleGrid.new(5, 11)

grid_5x11.each_cell_topleft.each_with_index do |yx, i|

  y,x = *yx
  write_number(img, x, y, i+1)

end

# write_number(img, 35,44 , 42)

img.write(TARGET_FILENAME)