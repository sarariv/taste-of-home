
class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    @stores = @tag.stores
  end

end
