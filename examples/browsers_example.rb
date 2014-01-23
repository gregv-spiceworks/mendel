require 'mendel'
include Mendel

browser = Variable.new('web browser', ['ie9', 'ie10', 'ff'])
os = Variable.new('operating system', ['vista', '7', '8', '8.1'])
version = Variable.new('operating system', ['1.0', '1.1'])
set_fitness_function(Fitness.method(:basic_all_pairs_fitness))
set_crossover_function(Crossover.method(:single_point_crossover))
add_variable(browser)
add_variable(os)
add_variable(version)

pop_size = 30
number_of_immigrants = 2

p = create_population(pop_size)

current_best_fitness = p[0].fitness

puts " 0 - #{current_best_fitness}"

10000.times do |i|

  if p[0].fitness > current_best_fitness then
    current_best_fitness = p[0].fitness
    puts " #{i} - #{current_best_fitness}"
  end

  p = evolve_population(p)
  if p[0].fitness == 26 then
    puts "SOLUTION FOUND at #{i.to_s}"
    puts p[0].pp
    exit
  end

  # Add immigrants
  p = add_immigrant(p, 2)

  if p[0].fitness == 26 then
    puts "SOLUTION FOUND at #{i.to_s}"
    puts p[0].pp
    exit
  end

end
