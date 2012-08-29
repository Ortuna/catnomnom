class CatnomnomController < ActionController::Base
  def index
    nomnom = Catnomnom.new
    cats = []
    json_url = "http://www.reddit.com/r/cats.json"
    entries = JSON.parse(Net::HTTP.get_response(URI.parse(json_url)).body)
    entries["data"]["children"].each do |entry|
      cats << entry["data"]["url"]
    end
    output = ""
    cats.each do |cat|
      output += "<img src=\"#{cat}\">"
    end
    render :text => output
  end

protected
  def get_cats(timestamp = 0)
    return 0
  end
end
