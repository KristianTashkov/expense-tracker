require 'spec_helper'

module ExpenseTracker
  describe HTMLGenerator do
    include HTMLGenerator

    describe "#pagination_link" do
      it "return link with page parameter if original link didn't have parameters" do
        pagination_link("/home", 1).should == "/home?page=1"
      end

      it "return link with page parameter if original link didn't have a page parameter" do
        pagination_link("/home?id=2", 1).should == "/home?id=2&page=1"
      end

      it "return link with changed page parameter when page parameter exists" do
        pagination_link("/home?id=2&page=2&user=kris", 1).should == "/home?id=2&page=1&user=kris"
      end
    end
  end
end