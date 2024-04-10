class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.includes(:images).find(params[:id])
    @images = @tag.images
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = current_user.images.new(image_params)
    if @tag.save
      redirect_to images_path, notice: 'Image was successfully uploaded.'
    else
      render :new
    end
  end

  def destroy
    @tag = Image.find(params[:id])
    @tag.destroy
    redirect_to images_path, notice: 'Image was successfully destroyed.'
  end

  private

  def image_params
    params.require(:tag).permit(:name)
  end
end
