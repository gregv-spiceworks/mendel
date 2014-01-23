require 'spec_helper'
require 'mendel'

p = Proc.new do |args|
  args[0] + args[1]
end

class Foo
  def self.f(a, b)
    a + b
  end
  def g(a, b)
    a + b
  end
  def self.h
    0
  end
end

describe Mendel do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
  it "should allow to set the fitness function from a proc" do
    set_fitness_function(p)
    fitness_function.call([2, 3]).should == 5
  end
  it "should allow to set the fitness function from a class method" do
    set_fitness_function(Foo.method(:f))
    fitness_function.call(2, 3).should == 5
  end
  it "should allow to set the fitness function from an instance method" do
    set_fitness_function(Foo.new.method(:g))
    fitness_function.call(2, 3).should == 5
  end
  describe "create_population" do
    it "there should be a create_population function" do
      lambda { Mendel::create_population(1) }.should_not raise_error
    end
    it "should not error out on argument == 0" do
      lambda { Mendel::create_population(0) }.should_not raise_error
    end
    it "should return an object of length equal to the argument" do
      Mendel::create_population(10).length.should == 10
    end
  end
  it "should have a add_variable method" do
    lambda { Mendel::add_variable(Variable.new('foo', [1, 2]))}.should_not raise_error
  end
  it "should have a configure method" do
    lambda { Mendel::configure([Variable.new('foo', [1, 2]), Variable.new('bar', ['a', 'b', 'c'])],
                               Foo.method(:h)) }.should_not raise_error
  end
end
