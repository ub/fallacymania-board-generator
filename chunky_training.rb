require 'oily_png'
require_relative 'lib/master_compatible_grid'
require_relative 'lib/master_grid_description_map'

image = ChunkyPNG::Image.from_file('rhetological-fallacies.png')

puts image.dimension.height
puts image.dimension.width

sample_target = ChunkyPNG::Image.new(200,200, ChunkyPNG::Color::WHITE)

buffer = image.crop(0,0,100,100)
sample_target.replace!(buffer)

sample_target.save('sample-out.png')

source_grid = MasterGrid.new



target_grid_4x14 = MasterCompatibleGrid.new(4,14)
puts '-'*10
puts target_grid_4x14.canvas_width
puts target_grid_4x14.canvas_height
puts '-'*10
target_grid_5x11 = MasterCompatibleGrid.new(5,11)
puts target_grid_5x11.canvas_width
puts target_grid_5x11.canvas_height
puts '-'*10
target_grid_5x12 = MasterCompatibleGrid.new(5,12)
puts target_grid_5x12.canvas_width
puts target_grid_5x12.canvas_height


target4x15 =  ChunkyPNG::Image.new(target_grid_4x14.canvas_width, target_grid_4x14.canvas_height, ChunkyPNG::Color::WHITE)
target5x11 =  ChunkyPNG::Image.new(target_grid_5x11.canvas_width, target_grid_5x11.canvas_height, ChunkyPNG::Color::WHITE)
target5x12 =  ChunkyPNG::Image.new(target_grid_5x12.canvas_width, target_grid_5x12.canvas_height, ChunkyPNG::Color::WHITE)


File::open('rhetological-fallacies.mgdm') do |f|

  @master_description = MasterGridDescriptionMap.new(f.each_line, 30)
end


# target_iterator = target_grid_4x14.each_cell_topleft
# source_grid.each_cell_topleft(@master_description.each_cell_index) do | y, x |
#   buffer = image.crop(x, y, source_grid.cell_width, source_grid.cell_height)
#   t_y, t_x = target_iterator.next
#   target4x15.replace!(buffer, t_x, t_y)
# end
#
# target4x15.save('almost_square.png')


target_iterator=target_grid_5x11.each_cell_topleft

source_grid.each_cell_topleft(@master_description.each_cell_index) do | y, x |
  buffer = image.crop(x, y, source_grid.cell_width, source_grid.cell_height)
  t_y, t_x = target_iterator.next
  target5x12.replace!(buffer, t_x, t_y)
end

zero = ChunkyPNG::Image.from_file('zero.png')
target_iterator = target_grid_5x12.each_cell_topleft( [[11, 0], [11, 1 ], [11, 2 ],[11, 3 ], [11, 4 ] ].each)
target_iterator.each do | y, x |
  target5x12.replace!(zero, x, y)
end

target5x12.save('5x12.png')