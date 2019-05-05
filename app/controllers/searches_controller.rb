class SearchesController < ApplicationController
  def result
    @searches = eval(params[:bulletin]).where("title like ?", "%#{params[:search_text]}%")

    render 'posts/index'
  end
end
