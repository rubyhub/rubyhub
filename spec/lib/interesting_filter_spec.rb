require 'spec_helper'

describe InterestingFilter do
  subject { described_class.new(%w(ruby rails)) }

  it "should match phrases with the full word" do
    subject.interesting?('ruby').should == true
  end

  it "should not match phrases without the word" do
    subject.interesting?('php').should == false
  end

  it "should not match phrases where the word is inside another word" do
    subject.interesting?('grails').should == false
  end
end
