class Fitness

  def self.basic_all_pairs_fitness(genes)
    value = 0
    genes.each do |row|
      row.each do |pairs|
        value += pairs.uniq.length
      end
    end
    value
  end

end