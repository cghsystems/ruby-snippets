#Quick example of monkey patching on to the Kernel class in Ruby.
#
#@see http://www.ruby-doc.org/docs/ProgrammingRuby/html/ref_m_kernel.html
#
#The Kernel class is a little like the System class in Java. It is where
#classes shuch as puts, p, lambda and proc live. Money patching describes a
#mechanism whereby a method can be added to the Kernel class to make it available
#to all classes.
#
#This example makes the 'should' method available to all classes
module Kernel
  def should
    Matcher.new(self)
  end
end

#The matcher class that performs the operations we want the should method to
#recognise. The actual class variable is the value presented before the 'should' 
#method
class Matcher
  def initialize(actual)
    @actual = actual
  end

  #Allows us to perfom a should == method to compare the actual (variable before the should) 
  #and the expected (variable after the should)
  define_method(:==) do|expected|
    expected == @actual
  end

  #Another way to define a method for should to recognise
  def say(something)
    "Say #{something}"
  end
end

raise "Expected true but got false" unless 5.should == 5
raise "Expected false but got true" if 6.should == 5

raise "Was expecting 'Say something'" unless should.say("something") == "Say something"

#Prints out 'Say something'
puts should.say "something"