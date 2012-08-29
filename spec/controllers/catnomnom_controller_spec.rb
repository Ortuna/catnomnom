require 'spec_helper'

describe CatnomnomController do
  render_views

  describe "GET #index" do 
    xit "Should have Catnomnom as the title" do
      get :index
      response.should have_selector :title, :content => "Catnomnom"
    end

    xit "Should have some cats" do
      get :index
      response.should have_selector :div, :class => 'cat'
    end

  end

  describe "GET #" do

  end

  describe "Util functions" do
    it "Should be able to retrieve some cats" do
      cats = controller.send(:get_cats)
      cats.should_not be_nil
    end

    xit "Should be able to retrieve some cats as an array" do
      cats = controller.send(:get_cats)
      cats.count.should_not == 0
    end

    xit "Should be able to retreve some cats by timestamp" do
      timestamp = 0
      cats = controller.send(:get_cats, timestamp)
      cats.should_not be_empty
    end
  end
end