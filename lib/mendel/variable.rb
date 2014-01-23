class Variable
  attr_reader :name, :range

  def initialize(name, range)
    @name = name
    @range = range
  end

  def random_value
    @range[rand(@range.length)]
  end

end