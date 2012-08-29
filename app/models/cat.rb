class Cat < ActiveRecord::Base
   attr_accessible :guid, :title, :image
   validates_presence_of :guid, :title, :image
   validate :email_checker
   
   def email_checker
    if image.nil? or image[/https?:\/\/[\S]+/].nil?
      errors.add :image, "Invalid url"    
    end
   end
end
