class Configuration
  include Singleton
  attr_reader :fitness_function, :crossover_function, :variables, :fitness_target

  def set_fitness_target_value(value)
    @fitness_target = value
  end

  def set(variables, f)
    set_fitness_function(f)
    variables.each { |v| add_variable(v)}
  end

  def set_fitness_function(f)
    @fitness_function = f
  end

  def set_crossover_function(f)
    @crossover_function = f
  end

  def add_variable(variable)
    @variables = Array.new if @variables.nil?
    @variables << variable
  end

end

