require 'spec_helper'

module ExpenseTracker
  describe HTMLGenerator do
    include HTMLGenerator
    PARAM = "some-parameter"

    describe "#add_parameter_to_link" do
      it "return link with parameter if original link didn't have parameters" do
        add_parameter_to_link("/home", PARAM,1).should == "/home?#{PARAM}=1"
      end

      it "return link with parameter if original link didn't have a parameter" do
        add_parameter_to_link("/home?id=2", PARAM, 1).should == "/home?id=2&#{PARAM}=1"
      end

      it "return link with changed parameter when parameter exists" do
        add_parameter_to_link("/home?id=2&#{PARAM}=2&user=kris", PARAM, 1).should == "/home?id=2&#{PARAM}=1&user=kris"
      end
    end
  end
end