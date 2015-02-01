require_relative 'preprocessor_enumerator'
class MasterGridDescriptionMap
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



  def initialize(line_enumerator, max_number_of_rows)
    @number_of_rows = max_number_of_rows
    @description_map=[]

    preproc = PreprocessorEnumerator.new(line_enumerator)
    row, column = 0, 0

    preproc.each do | line |
      s = line.strip
      STDERR.print("Bad format: #{s[0]} != '-'\n") unless s[0] == '-' # all other lines should start with '-'
      key = s[1..-1].lstrip
      unless key.empty? # empty string denotes blank cards on the original grid
        @description_map << [key, row, column]
      end

      row += 1
      if row == max_number_of_rows
        row, column = 0, column + 1
      end

    end
    if row == 0
      @number_of_columns = column
    else
      @number_of_columns = column + 1
    end
    if column == 0
      @number_of_rows = row
    end
  end

  attr_reader :number_of_rows, :number_of_columns

  def find_row_column(keystring)
    pattern = Pattern.new(keystring)
    found = @description_map.grep(pattern)
    return nil if found.size == 0
    $stderr.print("Ambiguous pattern #{pattern}; #{found.size} matches\n") if found.size != 1
    return found[0][1,2]
  end

  def each_cell_index
    if block_given?
      @description_map.each do |t,r,c|
        yield [r,c]
      end
    else
      self.enum_for(:each_cell_index)
    end

  end
end