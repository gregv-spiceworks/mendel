require 'singleton'
require 'mendel/version'

module Mendel
  require 'mendel/variable'
  require 'mendel/individual'
  require 'mendel/fitness'
  require 'mendel/crossover'

  ##############################################################################
  def method_missing(method_name, *args, &block)
    if Configuration.instance.respond_to?(method_name) then
      Configuration.instance.send(method_name, *args, &block)
    else
      super
    end
  end

  ##############################################################################

  def evolve_population(p, mutation_probability = 50)

    # randomly select parent1 and parent2
    pop_size = p.length                            # readability and performance
    population_mid_point = pop_size / 2            # readability and performance
    parent1_index = rand(population_mid_point)     # readability and performance
    parent2_index = rand(population_mid_point)     # readability and performance

    # Breed 2 children and pick the one to add to the population
    children = breed(p[parent1_index], p[parent2_index])
    child_to_be_added = (children[:child1].fitness >= children[:child2].fitness) ? children[:child1] : children[:child2]

    # if we reached our fitness target, we are done
    if child_to_be_added.fitness == Configuration.instance.fitness_target  then
      # put the child at the top of the population and return
      p[0] = child_to_be_added
      return p
    end

    # Apply mutation if needed
    if rand(100) < mutation_probability then
      child_to_be_added.mutate_gene()
    end

    # pick the individual to be removed
    individual_to_be_removed = pop_size - [parent1_index, parent2_index].max - 1

    # update the population
    p[individual_to_be_removed] = child_to_be_added
    p.sort! { |x, y| y.fitness <=> x.fitness }
    return p
  end

  def add_immigrant(p, number = 1)
    population_mid_point = p.length / 2            # readability and performance
    number.times do
      p[rand(population_mid_point) + population_mid_point] = Individual.new
      p.sort! { |x, y| y.fitness <=> x.fitness }
    end
    return p
  end
  ##############################################################################

  def configure(variables, f)
    Configuration.instance.set(variables, f)
  end

  def create_population(size)
    retval = Array.new
    size.times do
       retval << Individual.new
    end
    retval.sort { |x, y| y.fitness <=> x.fitness }
  end

  def breed(parent1, parent2)
    crossover_function.call(parent1, parent2)
  end
  ##############################################################################

end