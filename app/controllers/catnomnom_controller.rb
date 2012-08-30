class CatnomnomController < ActionController::Base
  def index
    @cats = random_cats
  end

  def cron
    cats = get_cats
    cats.each do |cat|
      c = Cat.new(:image => cat["image"], :title => cat["title"], :guid => cat["guid"])
      c.save
    end
    render :json => 1
  end

  def cats
    limit = params[:limit].to_i
    limit = 8 if limit.nil? or limit == 0
    
    @cats = random_cats(limit)
    render :json => @cats
  end

  def random_cats(limit = 8)
    @cats = Cat.all.shuffle.first(limit)
  end

protected
  def get_cats
    cats = []
    #http://www.reddit.com/r/kittens.json
    json_url = "http://www.reddit.com/r/cats.json"
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