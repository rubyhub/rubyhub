require 'spec_helper'

describe Admin::TwitterAccountController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'approve'" do
    it "should be successful" do
      get 'approve'
      response.should be_success
    end
  end

end
