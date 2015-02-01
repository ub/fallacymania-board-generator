#!/usr/bin/env ruby

module Helper
  class Pattern
    def initialize(str)
      rx_str = str.split.collect do |w|
        Regexp.escape(w)
      end.join('\s+')

      @regex = Regexp.new(rx_str, Regexp::IGNORECASE)
    end

    def ===(target_array)
      @regex === target_array.first
    end

    def to_s
      "{"+@regex.inspect+"}"
    end
  end

end

class MasterLayout
  attr_accessor :image_file, :rows, :columns
  GRID_H = 636.5
  GRID_V = 180.4

  CARD_WIDTH  = (GRID_H - 2).to_i
  CARD_HEIGHT = (GRID_V - 2).to_i

  NUMROWS = 30

  def initialize( names_file )
    @names=[]
    File.open(names_file) do | f |
      row, column = 0, 0
      f.each_line do | line |
        s = line.strip
        next if s.empty? or s[0] == ?; # Ignore empty lines or lines starting with ; (comments)


        STDERR.print("Bad format: #{s[0]} != '-'\n") unless s[0] == '-' # all other lines should start with '-'
        key = s[1..-1].lstrip
        unless key.empty? # empty string denotes blank cards on the original grid
          @names << [key, row, column]
        end

        row += 1
        if row == NUMROWS
          row, column = 0, column + 1
        end
      end
    end
  end

  #find row and column of the keystring
  def find_row_column(keystring)
    pattern =Helper::Pattern.new(keystring)
    found = @names.grep(pattern)
    return nil if found.size == 0
    STDERR.print("Ambiguous pattern #{pattern}; #{found.size} matches\n") if found.size != 1
    return found[0][1,2]
  end

  def debug
    @names.each do |l|
      puts l.join(", ")
    end
  end

end

ml=MasterLayout.new("rhetological-fallacies.mgdm")
#ml.debug
r,c =ml.search_row_column "Red HERR  "
print r, " ", c
