class Crossover

  def self.single_point_crossover(parent1, parent2, index = nil)
    swap_point = (index.nil?) ? parent1.length / 2 : index
    child1_genes = Array.new
    child2_genes = Array.new
    parent1.genes.each_with_index do |row, i|
      child1_genes[i] = Array.new
      child2_genes[i] = Array.new
      row.each_with_index do |pair_list, j|
        child1_genes[i][j] = Array.new
        child2_genes[i][j] = Array.new
        pair_list.each_with_index do |pair, k|
          if k < swap_point then
            child1_genes[i][j] << parent1.genes[i][j][k]
            child2_genes[i][j] << parent2.genes[i][j][k]
          else
            child1_genes[i][j] << parent2.genes[i][j][k]
            child2_genes[i][j] << parent1.genes[i][j][k]
          end
        end
      end
    end
    { :child1 => Individual.new(child1_genes), :child2 => Individual.new(child2_genes) }
  end

  def self.single_point_crossover2(parent1, parent2, index = nil)
    swap_point = (index.nil?) ? parent1.length / 2 : index
    child1_genes = Array.new
    child2_genes = Array.new
    parent1.genes.each_with_index do |row, i|
      child1_genes[i] = Array.new
      child2_genes[i] = Array.new
      row.each_with_index do |pair_list, j|
        child1_genes[i][j] = Array.new
        child2_genes[i][j] = Array.new
        pair_list.each_with_index do |pair, k|
          if k < swap_point then
            child1_genes[i][j] << parent1.genes[i][j][k]
            child2_genes[i][j] << parent2.genes[i][j][k]
          else
            child1_genes[i][j] << parent2.genes[i][j][k]
            child2_genes[i][j] << parent1.genes[i][j][k]
          end
        end
      end
    end
    { :child1 => Individual.new(child1_genes), :child2 => Individual.new(child2_genes) }
  end

  def self.crossover_with_probability(parent1, parent2, probability = 30)
    child1_genes = Array.new
    child2_genes = Array.new
    parent1.genes.each_with_index do |row, i|
      child1_genes[i] = Array.new
      child2_genes[i] = Array.new
      row.each_with_index do |pair_list, j|
        child1_genes[i][j] = Array.new
        child2_genes[i][j] = Array.new
        pair_list.each_with_index do |pair, k|
          if rand(100) > probability then
            child1_genes[i][j] << parent1.genes[i][j][k]
            child2_genes[i][j] << parent2.genes[i][j][k]
          else
            child1_genes[i][j] << parent2.genes[i][j][k]
            child2_genes[i][j] << parent1.genes[i][j][k]
          end
        end
      end
    end
    { :child1 => Individual.new(child1_genes), :child2 => Individual.new(child2_genes) }
  end

end