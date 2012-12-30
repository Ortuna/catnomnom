class CatnomnomController < ActionController::Base
  def index;end

  def cron
    Cat.update_database_with_new_cats
    render :json => 1
  end

  def cats
    limit = params[:limit]? params[:limit].to_i : 16
    render :json => Cat.random_cats(limit)
  end
end