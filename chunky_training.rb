require 'oily_png'
require_relative 'lib/master_compatible_grid'

image = ChunkyPNG::Image.from_file('rhetological-fallacies.png')

puts image.dimension.height
puts image.dimension.width

sample_target = ChunkyPNG::Image.new(200,200, ChunkyPNG::Color::WHITE)

buffer = image.crop(0,0,100,100)
sample_target.replace!(buffer)

sample_target.save('sample-out.png')

source_grid = MasterGrid.new



target_grid_4x15 = MasterCompatibleGrid.new(4,15)
puts target_grid_4x15.canvas_width
puts target_grid_4x15.canvas_height


target4x15 =  ChunkyPNG::Image.new(target_grid_4x15.canvas_width, target_grid_4x15.canvas_height, ChunkyPNG::Color::WHITE)


target_iterator = target_grid_4x15.each_cell_topleft
source_grid.each_cell_topleft do | y, x |
  buffer = image.crop(x, y, source_grid.cell_width, source_grid.cell_height)
  t_y, t_x = target_iterator.next
  target4x15.replace!(buffer, t_x, t_y)
end

target4x15.save('almost_square.png')



