class CatnomnomController < ActionController::Base
  def index
    # cron
    @cats = Cat.all.shuffle.first(8)
  end

  def cron
    cats = get_cats
    cats.each do |cat|
      c = Cat.new(:image => cat["image"], :title => cat["title"], :guid => cat["guid"])
      c.save
    end
  end

  def get_cats
    cats = []
    #http://www.reddit.com/r/kittens.json
    json_url = "http://www.reddit.com/r/kittens.json"
    entries = JSON.parse(Net::HTTP.get_response(URI.parse(json_url)).body)
    entries["data"]["children"].each do |entry|
      cat = {
              "image" => entry["data"]["url"],
              "title" => entry["data"]["title"],
              "guid" => entry["data"]["permalink"]
            }
      cats << cat
    end
    return cats
  end
end
