RSpec.describe "Matchers" do
  it "asserts on equality" do
    number = 3
    expect(number).to eq 3 # do not use 'should' because should is being deprecated
  end

  it "asserts on mathematical operators" do
    # 'be' is an operator comparable to another expression, it returns a matcher
    number = 5
    expect(number).to be >= 2
  end

  it "asserts on matching a regular expression" do
    email = "jose@tutsplus.com"
    regular_expression = /^\w+@\w+\.[a-z]{2,4}$/ # regular expression pattern written in between //
    # I want to make sure I have a full word \w+ where + means it \w will have characters to be greater than 1.
    # without the + next to \w, that means I only allow 1 character before the @ sign and after the @ sign.
    # an @ sign @
    # another word \w
    # a dot .
    # a series of characters between 2 - 4 that go between [a-z]
    # add at the beginning ^ and at the end $ to make sure that the email address matches the entire pattern, not just matches partially
    # without ^ and $ if you add email address like 'jose@tutsplus.rango' (rango is 5 characters, should be only 3 max) it will pass the test.
    expect(email).to match regular_expression
  end

  it "asserts on types and classes" do
    object = 2.3 # type of float
    # in Ruby 2.0 is a float, but 2 is a fixnum, but I want to accept 2.0 and 2 both as a numeric.

    expect(object).to be_an_instance_of Float # a Numeric is a class that inherits both from float and fixnum, so it will pass the test
    # use be_a if the class name begins with consonant e.g. Numeric
    # use be_an if the class name begins with vowel
    # "be_a" checks the inheritance chain, (Numeric inherits from Float)
    # "be_an_instance_of" checks the very direct class it is created from ,
    # so 2.3 is a float as its primary class, to check if 2.3 "be_an_instance_of" of Numeric will fail because Numeric is up in the inheritance chain.
    # If you check 2.3 "be_an_instance_of" Float, it will pass the test.
  end

  it "asserts on truthiness" do
    bool = true # 1.
    falsy_bool = false # 2.
    nil_value = nil # 3. nil is an object of nil class, false is an object of class boolean
    # If you want false and nil to be the same, we use a different matcher called "be_falsey"
    object = Class.new # 4.

    expect(bool).to be true # 1. test result: pass
    # expect(falsy_bool).to be false # 2. test result: pass
    # expect(falsy_bool).to be true # 2. test result: failed
    # expect(nil_value).to be true # 3. test result: failed
    # expect(nil_value).to be false # 3. test result: failed
    # expect(nil_value).to be_falsey # 3. test result: pass
    # expect(object).to be_truthy # 4. test result: pass, even though Class.new is not true
    # expect(object).to be true # 4. test result: failed, because we expect 'true' but we got a 'class'
  end


  it "expects errors" do
    expect do raise ArgumentError end.to raise_error
  end

  it "expects throws" do
    expect {
      throw :oops
    }.to throw_symbol :oops # test result: pass

    # if we were to write:
    # expect {
    #   throw :hooray
    # }.to throw_symbol :oops # test result: failed because expected :oops to be thrown, got :hooray

    # if I didn't throw anything, like this below, it will fail the test (wrong number of arguments (0 for 1..2))
    # expect {
    #   throw
    # }.to throw_symbol :oops
  end

  it "asserts on predicates" do
    # class A # declare a class named A
    #   def good? # create a function for the class A
    #     false # if returns false, the test will fail
    #   end # expected `#<A:0x007fc4fab8ef68>.good?` (with ? mark) to return true, got false
    # end

    class A # declare a class named A
      def good? # create a function for the class A
        true # if return true, the test will pass
      end
    end

    # class A # declare a class named A
    #   def good? # create a function for the class A
    #     A # returns class A, the test will pass
    #   end
    # end
    expect(A.new).to be_good # be_good uses good method from the newly created object from class A.
  end

  it "asserts on collection" do
    list = [
      :one,
      :two,
      :three
    ]
    # expect(list).to include :four # test result: failed
    # expect(list).to start_with :one # test result: pass
    # expect(list).to start_with :three # test result: failed
    # expect(list).to end_with :three # test result: pass
    # expect(list).to start_with [:one, :two] # test result: pass
    # expect(list).to start_with [:one, :three] # test result: failed because it is not beginning with :one, :three
    expect(list).to end_with [:two, :three] # test result: pass, the order matters
  end

  it "negates asserts" do # what if we want something NOT to be another thing?
    # in RSpec test we use .not_to to get the expectation negate itself
    expect(3).not_to be 5
  end
end
