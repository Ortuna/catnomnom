class Cat < ActiveRecord::Base
  attr_accessible :guid, :title, :image
  validates_presence_of :guid, :title, :image
  validate :email_checker   
  before_save :fix_imgr_url

  def email_checker
    if image.nil? or image[/https?:\/\/[\S]+/].nil?
      errors.add :image, "Invalid url"    
    end
  end

  def fix_imgr_url
    return if image.nil?
    matches = image.match(/.*imgur\.com\/(\w*)/)
    return false if matches.nil? or matches[1] == "a"
    self.image = "http://imgur.com/" + matches[1] + "l" + ".jpg"
  end
end
