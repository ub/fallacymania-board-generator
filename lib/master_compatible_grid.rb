require_relative 'basic_grid'
require_relative 'master_grid'
class MasterCompatibleGrid < BasicGrid
  def initialize(rows, columns)
    prototype = MasterGrid.new
    cw = prototype.cell_width
    ch = prototype.cell_height
    super(cw,ch,rows,columns)
  end
end