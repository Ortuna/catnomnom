require 'spec_helper'

def create_sample_cat
  sample_cat = Cat.new
  sample_cat.guid  = "12345zxcvy"
  sample_cat.title = "This is a test title"
  sample_cat.image = "http://imgur.com/bM2XPl.jpg"
  sample_cat
end

describe Cat do
  it "should exist" do
    c = create_sample_cat
    c.should_not be_nil
  end

  it "should have guid" do
    c = create_sample_cat
    c.guid = "12345"
    c.guid.should == "12345"
  end

  it "should have a title" do
    c = create_sample_cat
    c.title = "Test Title"
    c.title.should == "Test Title"
  end 

  it "should have an image" do
    c = create_sample_cat
    c.image = "http://www.google.com/logo.png"
    c.image.should == "http://www.google.com/logo.png"
  end

  it "should not save if guid is missing" do
    c = create_sample_cat
    c.guid  = nil
    c.save.should == false
    c.errors[:guid].should_not be_nil
  end

  it "should not save if a title is missing" do
    c = create_sample_cat
    c.title = nil
    c.save.should == false
    c.errors[:title].should_not be_nil
  end

  it "should not save if an image is missing" do
    c = create_sample_cat
    c.image = nil
    c.save.should == false
    c.errors[:image].should_not be_nil
  end

  it "should save when everything is present" do
    c = create_sample_cat
    c.save.should == true
  end

  it "should be retrievable" do
    c = create_sample_cat
    c.save
    id = c.id
    Cat.find(id).should_not be_nil
  end

  it "should not save a bad image URL" do
    c = create_sample_cat
    c.image = "abc.def"
    c.save.should == false
  end
end
