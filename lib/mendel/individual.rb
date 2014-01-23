require_relative './configuration'

class Individual
  attr_reader :length, :genes

  def initialize(genes = nil)
    if genes.nil? then
      @genes = Array.new(variables.length - 1)
      @genes.each_with_index do |row, i|
        @genes[i] = Array.new(i + 1, Array.new)
        @genes[i].each_with_index { |e, j| @genes[i][j] = Array.new }
      end
      compute_length.times do
        add_gene(random_gene)
      end
    else
      @genes = genes
      @length = genes[0][0].length
    end
  end

  def add_gene(gene)
    gene.each_with_index do |row, i|
      row.each_with_index do |pair, j|
        @genes[i][j] << gene[i][j]
      end
    end
  end

  def compute_length
    sorted_var = variables.sort { |x, y| y.range.length <=> x.range.length }
    @length = sorted_var[0].range.length * sorted_var[1].range.length
  end

  def random_gene
    retval = Array.new
    v = variables # to prevent going through the call chain too many times
    values = Array.new
    v.each { |e| values << e.random_value }
    (v.length - 1).times do |i|
      retval[i] = Array.new
      (i + 1).times do |j|
        retval[i][j] = [values[j], values[i + 1]]
      end
    end
    retval
  end

  def remove_gene(index)
    retval = Array.new
    pair = Array.new
    @genes.each_with_index do |row, i|
      row.each_with_index do |pair, j|
        pair = @genes[i][j].delete_at(index)
        retval[0] = pair[0] if ( i == 0 and j == 0)
        retval[i + 1] = pair[1] if i == j
      end
   end
    retval
  end

  def mutate_gene(index = nil)
    index = rand(@length) if index.nil?
    g = remove_gene(index)
    add_gene(random_gene)
  end

  def fitness
    # TODO: explore ways to not have to pass arguments
    fitness_function.call(@genes)
  end

  def pp
    s = ''
    @length.times do |i|
      s = "#{@genes[0][0][i][0]}"
      @genes.length.times do |j|
        s += ", #{@genes[j][j][i][1]}"
      end
      puts s
    end
    nil
  end

  def ==(o)
    self.fitness == o.fitness
  end
  alias_method :eql?, :==

  def hash
    h = 0
    p = 31 # just a prime number
    @genes.each do |g|
      h = h * (p + g.hash)
    end
    h
  end

end