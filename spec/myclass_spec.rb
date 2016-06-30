require "myclass"

RSpec.describe MyClass do
  it "says hello" do
    expect(MyClass.new.hello).to include "Hello" #Uppercase H
  end
end
