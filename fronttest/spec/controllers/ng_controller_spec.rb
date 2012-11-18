require 'spec_helper'

describe NgController do

  describe "GET 'dashboard'" do
    it "returns http success" do
      get 'dashboard'
      response.should be_success
    end
  end

  describe "GET 'categories'" do
    it "returns http success" do
      get 'categories'
      response.should be_success
    end
  end

  describe "GET 'items'" do
    it "returns http success" do
      get 'items'
      response.should be_success
    end
  end

end
