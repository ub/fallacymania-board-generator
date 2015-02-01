require 'active_support'
require 'active_support/core_ext/object'

class PreprocessorEnumerator < Enumerator
  def initialize(upstream_enum)
    @upstream = upstream_enum
  end

  def next
    value = @upstream.next
    until good?(value)
      value = @upstream.next
    end
    value
  end

  def rewind
    @upstream.rewind
  end

  def each
    return self unless block_given?
    self.rewind
    result = []
    loop do
      val = self.next
      result << val
      yield val
    end
    result
  end

  private
  def good?(str)
    ! ( str.blank? || /^\s*;/ =~ str )
  end

end

