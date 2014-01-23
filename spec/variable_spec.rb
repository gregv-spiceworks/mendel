require 'spec_helper'
require 'mendel'
include Mendel

describe Variable do
  it "should have a constructor" do
    Variable.new('name', [1, 2, 3]).should_not be_nil
  end
end
