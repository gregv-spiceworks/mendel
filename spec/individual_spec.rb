require 'spec_helper'
require 'mendel'
include Mendel

p = Proc.new do |args|
  args[0] + args[1]
end

g = Proc.new do
  0
end

describe Individual do
  before(:each) do
    set_fitness_function(g)
    add_variable(Variable.new('a', [1, 2, 3]))
    add_variable(Variable.new('b', ['A', 'B']))
  end
  it "should have a constructor" do
    Individual.new().should_not be_nil
  end
  it "should allow comparison" do
    lambda { Individual.new == Individual.new }.should_not raise_error
    lambda { Individual.new.hash }.should_not raise_error
    lambda { Individual.new <=> Individual.new }.should_not raise_error
  end
  it "should have a fitness method" do
    subject.should respond_to(:fitness)
  end
  describe "fitness" do
    it "should be used to order individuals" do
      i1 = Individual.new
      i2 = Individual.new
      i3 = Individual.new
      a = [i1, i2, i3].sort
      a[0].fitness.should >= a[1].fitness
      a[0].fitness.should >= a[2].fitness
      a[1].fitness.should >= a[2].fitness
    end
  end
end
