class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def show
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "Tag successfully created!"
      redirect_to tags_path
    else
      render 'new'
    end
  end

  private
    def tag_params
        params.require(:tag).permit(:name)
    end
end
