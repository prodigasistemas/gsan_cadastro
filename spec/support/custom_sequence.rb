class FGCustomSequence
  def initialize(max)
    @marker, @max = 1, max
  end
  def next
    @marker = (@marker >= @max ? 1 : (@marker + 1))
  end
  def peek
    @marker.to_s
  end
end