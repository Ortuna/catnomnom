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

  def self.random_cats(limit = 16)
    @cats = Cat.order("RAND()").limit(limit).shuffle
  end

  def self.update_database_with_new_cats
    cats = Cat.update_from_sources
    cats.each do |cat|
      next unless Cat.find_by_guid(cat["guid"]).nil?
      c = Cat.new(:image => cat["image"], :title => cat["title"], :guid => cat["guid"])
      c.save
    end
  end

  def self.update_from_sources
    cats     = []
    cat_urls = []
    cat_urls << "http://www.reddit.com/r/kittens.json"
    cat_urls << "http://www.reddit.com/r/cats.json"
    cat_urls << "http://www.reddit.com/r/cats/new/.json"

    cat_urls.each do |json_url|
      entries = JSON.parse(Net::HTTP.get_response(URI.parse(json_url)).body)
      entries["data"]["children"].each do |entry|
        cat = {
                "image" => entry["data"]["url"],
                "title" => entry["data"]["title"],
                "guid" => entry["data"]["permalink"]
              }
        cats << cat
      end
    end

    return cats
  end
end
